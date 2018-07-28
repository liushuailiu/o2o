package com.hmb.service;

import com.github.pagehelper.PageInfo;
import com.hmb.dto.ShopExecution;
import com.hmb.pojo.Shop;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.List;


public interface ShopService {
    /**
     * 添加店铺
     * @param shop
     * @param shopImg
     * @return
     */
    ShopExecution AddShop(Shop shop,CommonsMultipartFile shopImg);

    /**
     * 通过店铺id获取店铺信息
     * @param shopId
     * @return
     */
    Shop getByShopId(int shopId);

    /**
     * 更新店铺信息
     * @param shop
     * @param shopImg
     * @return
     */
    ShopExecution modifyShop(Shop shop,CommonsMultipartFile shopImg);

    ShopExecution getShopList(Shop shopCondition, int pageIndex, int pageSize);

    ShopExecution getByEmployeeId(int employeeId) throws RuntimeException;
}
