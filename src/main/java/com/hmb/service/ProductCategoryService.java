package com.hmb.service;

import com.hmb.dto.ProductCategoryExecution;
import com.hmb.pojo.ProductCategory;


import java.util.List;

public interface ProductCategoryService {
	/**
	 * 查询指定某个店铺下的所有商品类别信息
	 *
	 * @return List<ProductCategory>
	 */
	List<ProductCategory> getByShopId(int shopId);

	/**
	 * 
	 * @param
	 * @return
	 * @throws RuntimeException
	 */
	ProductCategoryExecution batchAddProductCategory(
            List<ProductCategory> productCategoryList) throws RuntimeException;

	/**
	 *
	 * @param productCategoryId
	 * @param shopId
	 * @return
	 * @throws RuntimeException
	 */
	ProductCategoryExecution deleteProductCategory(int productCategoryId,
                                                   int shopId) throws RuntimeException;
}
