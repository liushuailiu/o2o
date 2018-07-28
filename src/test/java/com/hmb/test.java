package com.hmb;

import com.hmb.dao.ShopCategoryMapper;
import com.hmb.dao.ShopMapper;
import com.hmb.pojo.Shop;
import com.hmb.pojo.ShopCategory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class test extends BaseTest {
    @Autowired
    ShopMapper shopMapper;
    @Test
    public void test(){
        Shop shop = new Shop();
        ShopCategory child = new ShopCategory();
        ShopCategory parent = new ShopCategory();
        parent.setShopCategoryId(12);
        child.setParent(parent);
        shop.setShopCategory(child);
        List<Shop> shopList = shopMapper.queryShopList(shop);
        System.out.println(shopList);

    }
}
