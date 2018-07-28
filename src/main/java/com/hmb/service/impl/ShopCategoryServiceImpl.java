package com.hmb.service.impl;

import com.hmb.dao.ShopCategoryMapper;
import com.hmb.pojo.ShopCategory;
import com.hmb.service.ShopCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class ShopCategoryServiceImpl implements ShopCategoryService {
    @Autowired
    private ShopCategoryMapper shopCategoryMapper;

    @Override
    public List<ShopCategory> queryShopCategory(ShopCategory shopCategory) {
        return shopCategoryMapper.queryShopCategory(shopCategory);
    }
}
