package com.hmb.service;

import com.hmb.dto.ProductExecution;
import com.hmb.pojo.Product;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.List;

public interface ProductService {


	/**
	 * 添加商品信息及图片处理
	 * @param product
	 * @param thumbnail 缩略图
	 * @param productImgs 详情图
	 * @return
	 * @throws RuntimeException
	 */
	ProductExecution addProduct(Product product, CommonsMultipartFile thumbnail, List<CommonsMultipartFile> productImgs)
			throws RuntimeException;

	/**
	 * 查询产品信息通过产品id
	 * @param productId
	 * @return
	 */
	Product getProductById(int productId);

	ProductExecution modifyProduct(Product product, CommonsMultipartFile thumbnail,
								   List<CommonsMultipartFile> productImgs) throws RuntimeException;

	ProductExecution getProductList(Product productCondition, int pageIndex, int pageSize);



}
