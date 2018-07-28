package com.hmb.dao;

import com.hmb.pojo.Shop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopMapper {
    int deleteByPrimaryKey(Integer shopId);

    int insert(Shop record);

    int insertSelective(Shop record);

    Shop selectByPrimaryKey(Integer shopId);

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);


    int updateSelective(@Param("shopImg") String shopImg,@Param("shopName") String shopName);

    Shop queryByShopId(int shopId);

    /**
     * 分页查询店铺,可输入的条件有：店铺名（模糊），店铺状态，店铺Id,店铺类别,区域ID
     *
     * @param shopCondition
     * @return
     */
    List<Shop> queryShopList(@Param("shopCondition") Shop shopCondition);

    List<Shop> queryByEmployeeId(int employeeId);
}