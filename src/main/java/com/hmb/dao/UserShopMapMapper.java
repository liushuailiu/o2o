package com.hmb.dao;

import com.hmb.pojo.UserShopMap;

public interface UserShopMapMapper {
    int deleteByPrimaryKey(Integer userShopId);

    int insert(UserShopMap record);

    int insertSelective(UserShopMap record);

    UserShopMap selectByPrimaryKey(Integer userShopId);

    int updateByPrimaryKeySelective(UserShopMap record);

    int updateByPrimaryKey(UserShopMap record);
}