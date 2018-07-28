package com.hmb.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hmb.dao.ShopMapper;
import com.hmb.dto.ShopExecution;
import com.hmb.enums.ShopStateEnum;
import com.hmb.exception.ShopOperationException;
import com.hmb.pojo.Shop;
import com.hmb.service.ShopService;
import com.hmb.util.ImageUtil;
import com.hmb.util.PathUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.Date;
import java.util.List;

@Service
public class ShopServiceImpl implements ShopService {
    @Autowired
    private ShopMapper shopMapper;

    @Override
    @Transactional
    public ShopExecution AddShop(Shop shop, CommonsMultipartFile shopImg) {
        //控制判断
        if (shop == null) {
            return new ShopExecution(ShopStateEnum.NULL_SHOP_INFO);
        }
        try {
            //给店铺信息附初始值
            shop.setEnableStatus(0);
            shop.setCreateTime(new Date());
            shop.setLastEditTime(new Date());
            //添加店铺信息
            int effectedNum = shopMapper.insertSelective(shop);
            System.out.println(shop.getShopId());
            if (effectedNum <= 0) {
                throw new ShopOperationException("店铺创建失败");
            } else {
                try {
                    if (shopImg != null) {
                        //生成缩略图
                        String shopImgAddr = addShopImg(shop, shopImg);
                        System.out.println(shopImgAddr);
                        effectedNum = shopMapper.updateSelective(shopImgAddr,shop.getShopName());
                        if (effectedNum <= 0) {
                            throw new ShopOperationException("创建图片地址失败");
                        }
                    }
                } catch (Exception e) {
                    throw new ShopOperationException("addShopImg error: "
                            + e.getMessage());
                }


            }
        } catch (Exception e) {
            throw new ShopOperationException("insertShop error: " + e.getMessage());
        }
        return new ShopExecution(ShopStateEnum.SUCCESS,shop);
    }

    private String addShopImg(Shop shop, CommonsMultipartFile shopImg) {
        String dest = PathUtil.getShopImagePath(shop.getShopId());
        String shopImgAddr = ImageUtil.generateThumbnail(shopImg, dest);
        return shopImgAddr;
    }

    @Override
    public Shop getByShopId(int shopId) {
        return shopMapper.queryByShopId(shopId);
    }

    @Override
    public ShopExecution modifyShop(Shop shop, CommonsMultipartFile shopImg) {
        if (shop == null || shop.getShopId() == null) {
            return new ShopExecution(ShopStateEnum.NULL_SHOPID);
        } else {
            try {
                //1.判断是否需要处理文件
                if (shopImg != null) {
                    Shop tempShop = shopMapper.queryByShopId(shop.getShopId());
                    if (tempShop.getShopImg() != null) {
                        PathUtil.deleteFile(tempShop.getShopImg());
                    }
                    addShopImg(shop, shopImg);
                }
                shop.setLastEditTime(new Date());
                //2.更新店铺信息
                int effectedNum = shopMapper.updateByPrimaryKeySelective(shop);
                if (effectedNum <= 0) {
                    return new ShopExecution(ShopStateEnum.INNER_ERROR);
                } else {// 创建成功
                    shop = shopMapper.queryByShopId(shop.getShopId());
                    return new ShopExecution(ShopStateEnum.SUCCESS, shop);
                }
            } catch (Exception e) {
                throw new RuntimeException("modifyShop error: "
                        + e.getMessage());
            }
        }
    }

    @Override
    public ShopExecution getShopList(Shop shopCondition, int pageIndex, int pageSize) {
        PageHelper.startPage(pageIndex,pageSize);
        PageInfo<Shop> pageInfo = new PageInfo<>(shopMapper.queryShopList(shopCondition));
        List<Shop> shopList = pageInfo.getList();
        int count = pageInfo.getSize();
        ShopExecution se = new ShopExecution();
        if (shopList != null) {
            se.setShopList(shopList);
            se.setCount(count);
            se.setState(ShopStateEnum.SUCCESS.getState());
            se.setStateInfo(ShopStateEnum.SUCCESS.getStateInfo());
        } else {
            se.setState(ShopStateEnum.INNER_ERROR.getState());
            se.setStateInfo(ShopStateEnum.INNER_ERROR.getStateInfo());
        }
        return se;
    }

    @Override
    public ShopExecution getByEmployeeId(int employeeId) throws RuntimeException {
        List<Shop> shopList = shopMapper.queryByEmployeeId(employeeId);
        ShopExecution se = new ShopExecution();
        se.setShopList(shopList);
        return se;
    }


}
