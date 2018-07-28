package com.hmb.dao;

import com.hmb.pojo.ProductImg;

import java.util.List;

public interface ProductImgMapper {
    int deleteByPrimaryKey(Integer productImgId);

    int insert(ProductImg record);

    int insertSelective(ProductImg record);

    ProductImg selectByPrimaryKey(Integer productImgId);

    int updateByPrimaryKeySelective(ProductImg record);

    int updateByPrimaryKey(ProductImg record);

    int batchInsertProductImg(List<ProductImg> productImgList);

    List<ProductImg> queryProductImgList(int productId);

    int deleteProductImgByProductId(int productId);
}