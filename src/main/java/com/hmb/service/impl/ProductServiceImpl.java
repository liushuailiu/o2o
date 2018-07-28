package com.hmb.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hmb.dao.ProductImgMapper;
import com.hmb.dao.ProductMapper;
import com.hmb.dto.ProductExecution;
import com.hmb.enums.ProductStateEnum;
import com.hmb.pojo.Product;
import com.hmb.pojo.ProductImg;
import com.hmb.service.ProductService;
import com.hmb.util.ImageUtil;
import com.hmb.util.PathUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductMapper productMapper;
	@Autowired
	private ProductImgMapper productImgMapper;




	/**
	 * 1.处理缩略图，获取缩略图相对路径并赋值给product
	 * 2.往tb_product写入商品信息，获取productId
	 * 3.结合productId批量处理商品详情图
	 * 4.想商品相详情图列表批量插入tb_product_img中
	 * @param product
	 * @param thumbnail 缩略图
	 * @param productImgs 详情图
	 * @return
	 * @throws RuntimeException
	 */
	@Override
	@Transactional
	public ProductExecution addProduct(Product product, CommonsMultipartFile thumbnail,
			List<CommonsMultipartFile> productImgs) throws RuntimeException {
		if (product != null && product.getShop() != null && product.getShop().getShopId() != null) {
			product.setCreateTime(new Date());
			product.setLastEditTime(new Date());
			product.setEnableStatus(1);
			if (thumbnail != null) {
				//处理缩略图，获取缩略图相对路径并赋值给product
				addThumbnail(product, thumbnail);
			}
			try {
				//创建商品信息
				int effectedNum = productMapper.insert(product);
				if (effectedNum <= 0) {
					throw new RuntimeException("创建商品失败");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("创建商品失败:" + e.toString());

			}
			if (productImgs != null && productImgs.size() > 0) {
				//结合productId批量处理商品详情图
				addProductImgs(product, productImgs);
			}
			return new ProductExecution(ProductStateEnum.SUCCESS, product);
		} else {
			return new ProductExecution(ProductStateEnum.EMPTY);
		}
	}

	@Override
	@Transactional
	public Product getProductById(int productId) {
		return productMapper.queryProductByProductId(productId);
	}

	/**
	 * 1.若缩略图参数有值，则处理缩略图
	 * 若原先存在则先删除在添加新图，之后获取缩略图相对路径并赋值给product
	 * 2.若商品详情图列表参数有值，对商品详情图片列表进行同样的操作
	 * 3.将tb_product_img下面的该商品原先的商品详情图记录全清除
	 * 4.更新tb_product以及tb_product_img的信息
	 * @param product
	 * @param thumbnail
	 * @param productImgs
	 * @return
	 * @throws RuntimeException
	 */
	@Override
	@Transactional
	public ProductExecution modifyProduct(Product product, CommonsMultipartFile thumbnail, List<CommonsMultipartFile> productImgs) throws RuntimeException {
		//空值判断
		if (product != null && product.getShop() != null && product.getShop().getShopId() != null) {
			//给商品设上默认属性
			product.setLastEditTime(new Date());
			if (thumbnail != null) {
				Product tempProduct = productMapper.queryProductByProductId(product.getProductId());
				if (tempProduct.getImgAddr() != null) {
					PathUtil.deleteFile(tempProduct.getImgAddr());
				}
				addThumbnail(product, thumbnail);
			}
			if (productImgs != null && productImgs.size() > 0) {
				deleteProductImgs(product.getProductId());
				addProductImgs(product, productImgs);
			}
			try {
				int effectedNum = productMapper.updateProduct(product);
				if (effectedNum <= 0) {
					throw new RuntimeException("更新商品信息失败");
				}
				return new ProductExecution(ProductStateEnum.SUCCESS, product);
			} catch (Exception e) {
				throw new RuntimeException("更新商品信息失败:" + e.toString());
			}
		} else {
			return new ProductExecution(ProductStateEnum.EMPTY);
		}
	}

	@Override
	public ProductExecution getProductList(Product productCondition, int pageIndex, int pageSize) {
		PageHelper.startPage(pageIndex,pageSize);
		List<Product> productList = productMapper.queryProductList(productCondition);
		PageInfo<Product> pageInfo = new PageInfo<>(productList);
		int count = pageInfo.getSize();
		ProductExecution pe = new ProductExecution();
		pe.setProductList(pageInfo.getList());
		pe.setCount(count);
		return pe;
	}


	private void addProductImgs(Product product, List<CommonsMultipartFile> productImgs) {
		//获取图片存储路径，这里直接存放到相应店铺文件件下边
		String dest = PathUtil.getShopImagePath(product.getShop().getShopId());
		//向本地保存图片
		List<String> imgAddrList = ImageUtil.generateNormalImgs(productImgs, dest);
		//遍历图片一次去处理，并添加进productImg实体类中
		if (imgAddrList != null && imgAddrList.size() > 0) {
			List<ProductImg> productImgList = new ArrayList<ProductImg>();
			for (String imgAddr : imgAddrList) {
				ProductImg productImg = new ProductImg();
				productImg.setImgAddr(imgAddr);
				productImg.setProductId(product.getProductId());
				productImg.setCreateTime(new Date());
				productImgList.add(productImg);
			}
			try {
				int effectedNum = productImgMapper.batchInsertProductImg(productImgList);
				if (effectedNum <= 0) {
					throw new RuntimeException("创建商品详情图片失败");
				}
			} catch (Exception e) {
				throw new RuntimeException("创建商品详情图片失败:" + e.toString());
			}
		}
	}


	/**
	 * 处理缩略图
	 * @param product
	 * @param thumbnail
	 */
	private void addThumbnail(Product product, CommonsMultipartFile thumbnail) {
		String dest = PathUtil.getShopImagePath(product.getShop().getShopId());
		String thumbnailAddr = ImageUtil.generateThumbnail(thumbnail, dest);
		product.setImgAddr(thumbnailAddr);
	}

	private void deleteProductImgs(int productId) {
		//根据productId获取原来的图片
		List<ProductImg> productImgList = productImgMapper.queryProductImgList(productId);
		//删除原来的图片
		for (ProductImg productImg : productImgList) {
			PathUtil.deleteFile(productImg.getImgAddr());
		}
		//删除数据库里原来的图片的信息
		productImgMapper.deleteProductImgByProductId(productId);
	}
}
