package com.hmb.dao;

import com.hmb.pojo.UserAwardMap;

public interface UserAwardMapMapper {
    int deleteByPrimaryKey(Integer userAwardId);

    int insert(UserAwardMap record);

    int insertSelective(UserAwardMap record);

    UserAwardMap selectByPrimaryKey(Integer userAwardId);

    int updateByPrimaryKeySelective(UserAwardMap record);

    int updateByPrimaryKey(UserAwardMap record);
}