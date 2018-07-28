package com.hmb.view.shopadmin;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hmb.dto.ShopExecution;
import com.hmb.enums.ShopStateEnum;
import com.hmb.pojo.Area;
import com.hmb.pojo.PersonInfo;
import com.hmb.pojo.Shop;
import com.hmb.pojo.ShopCategory;
import com.hmb.service.AreaService;
import com.hmb.service.ShopCategoryService;
import com.hmb.service.ShopService;
import com.hmb.util.CodeUtil;
import com.hmb.util.HttpServletRequestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@RestController
@RequestMapping("/shopadmin")
public class ShopManagementController {

    @Autowired
    private ShopService shopService;
    @Autowired
    private AreaService areaService;
    @Autowired
    private ShopCategoryService shopCategoryService;

    /**
     * 通过店铺id 获取店铺管理页面信息
     * 如果没有传入id 就重定向到商店列表页面
     * @param request
     * @return
     */
    @GetMapping("/getshopmanagementinfo")
    private Map<String,Object> getShopManagementInfo(HttpServletRequest request){
        Map<String,Object> modelMap = new HashMap<>();
        int shopId = HttpServletRequestUtil.getInt(request,"shopId");
        if(shopId <= 0){
            Object currentShopObj = request.getSession().getAttribute("currentShop");
            if(currentShopObj == null){
                modelMap.put("redirect",true);
                modelMap.put("url","/shop/shoplist");
            }else {
                Shop currentShop = (Shop) currentShopObj;
                modelMap.put("redirect",false);
                modelMap.put("shopId",currentShop.getShopId());
            }

        }else {
            Shop currentShop = new Shop();
            currentShop.setShopId(shopId);
            request.getSession().setAttribute("currentShop",currentShop);
            modelMap.put("redirect",false);
        }
        return modelMap;
    }

    /**
     * 查看店铺信息  通过店铺id初始化店铺信息
     * @param request
     * @return
     */
    @GetMapping("/getshopbyid")
    private  Map<String,Object> getShopById(HttpServletRequest request){
        Map<String, Object> modelMap = new HashMap<String, Object>();
        int shopId = HttpServletRequestUtil.getInt(request,"shopId");
        if(shopId> -1){
            try {
                Shop shop = shopService.getByShopId(shopId);
                List<Area> areaList = areaService.getArealist();
                modelMap.put("shop",shop);
                modelMap.put("areaList",areaList);
                modelMap.put("success",true);
            }catch (Exception e){
                modelMap.put("success",false);
            }

        }
        return modelMap;
    }

    /**
     * 注册店铺时初始化 店铺分类和店铺区域的下拉框
     * @return
     */
    @RequestMapping(value = "/getshopinitinfo", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> getShopInitInfo() {
        Map<String, Object> modelMap = new HashMap<String, Object>();

        List<ShopCategory> shopCategoryList = new ArrayList<ShopCategory>();
        List<Area> areaList = new ArrayList<Area>();
        try {
            shopCategoryList = shopCategoryService
                    .queryShopCategory(new ShopCategory());
            areaList = areaService.getArealist();
        } catch (Exception e) {
            modelMap.put("success", false);
            modelMap.put("errMsg", e.toString());
        }
        modelMap.put("shopCategoryList", shopCategoryList);
        modelMap.put("areaList", areaList);
        modelMap.put("success", true);
        return modelMap;
    }

    /**
     * 注册店铺
     * @param request
     * @return
     */
    @RequestMapping(value = "/registershop", method = RequestMethod.POST)
    private Map<String, Object> registerShop(HttpServletRequest request) {
        Map<String, Object> modelMap = new HashMap<>();
        if (CodeUtil.checkVerifyCode(request)) {
            modelMap.put("success", false);
            modelMap.put("errMsg", "输入了错误的验证码");
            return modelMap;
        }
        //1.接收并转化相应的参数，包括店铺信息以及图片信息
        ObjectMapper mapper = new ObjectMapper();
        Shop shop = null;
        String shopStr = HttpServletRequestUtil.getString(request, "shopStr");
        try {
            //转成实体类对象
            shop = mapper.readValue(shopStr, Shop.class);
        } catch (Exception e) {
            modelMap.put("success", false);
            modelMap.put("errMsg", e.toString());
            return modelMap;
        }
        //获取前端传过来的文件流
        MultipartHttpServletRequest multipartRequest = null;
        CommonsMultipartFile shopImg = null;
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //判断是否有上传的文件流
        if (multipartResolver.isMultipart(request)) {
            multipartRequest = (MultipartHttpServletRequest) request;
            shopImg = (CommonsMultipartFile) multipartRequest
                    .getFile("shopImg");
            System.out.println(shopImg.getOriginalFilename());
        } else {
            modelMap.put("success", false);
            modelMap.put("errMsg", "上传图片不能为空");
            return modelMap;
        }
        //2.注册店铺
        if (shop != null && shopImg != null) {

                PersonInfo user = (PersonInfo) request.getSession()
                        .getAttribute("user");
                shop.setOwnerId(user.getUserId());
                ShopExecution se = null;
                try {
                    se = shopService.AddShop(shop, shopImg);
                    if (se.getState() == ShopStateEnum.CHECK.getState()) {
                        modelMap.put("success", true);
                        // 若shop创建成功，则加入session中，作为权限使用
                        @SuppressWarnings("unchecked")
                        List<Shop> shopList = (List<Shop>) request.getSession()
                                .getAttribute("shopList");
                        if (shopList == null && shopList.size() == 0) {
                            shopList = new ArrayList<Shop>();

                        }
                        shopList.add(se.getShop());
                        request.getSession().setAttribute("shopList", shopList);
                    } else {
                        modelMap.put("success", false);
                        modelMap.put("errMsg", se.getStateInfo());
                    }


            } catch (RuntimeException e) {
                modelMap.put("success", false);
                modelMap.put("errMsg", e.toString());
                return modelMap;
            }

        } else {
            modelMap.put("success", false);
            modelMap.put("errMsg", "请输入店铺信息");
        }
        modelMap.put("success",true);
        modelMap.put("errMsg", "添加成功");
        return modelMap;
    }

    /**
     * 修改店铺信息
     * @param request
     * @return
     */
    @RequestMapping(value = "/modifyshop", method = RequestMethod.POST)
    private Map<String, Object> modifyShop(HttpServletRequest request) {
        Map<String, Object> modelMap = new HashMap<>();
        if (CodeUtil.checkVerifyCode(request)) {
            modelMap.put("success", false);
            modelMap.put("errMsg", "输入了错误的验证码");
            return modelMap;
        }
        //1.接收并转化相应的参数，包括店铺信息以及图片信息
        ObjectMapper mapper = new ObjectMapper();
        Shop shop = null;
        String shopStr = HttpServletRequestUtil.getString(request, "shopStr");
        try {
            //转成实体类对象
            shop = mapper.readValue(shopStr, Shop.class);
        } catch (Exception e) {
            modelMap.put("success", false);
            modelMap.put("errMsg", e.toString());
            return modelMap;
        }
        //获取前端传过来的文件流
        MultipartHttpServletRequest multipartRequest = null;
        CommonsMultipartFile shopImg = null;
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //判断是否有上传的文件流
        if (multipartResolver.isMultipart(request)) {
            multipartRequest = (MultipartHttpServletRequest) request;
            shopImg = (CommonsMultipartFile) multipartRequest
                    .getFile("shopImg");
            System.out.println(shopImg.getOriginalFilename());
        } else {
            modelMap.put("success", false);
            modelMap.put("errMsg", "上传图片不能为空");
            return modelMap;
        }
        //2.注册店铺
        if (shop != null && shop.getShopId() != null) {

            PersonInfo user = new PersonInfo();
            shop.setOwnerId(9);
            ShopExecution se = null;
            try {
                if(shopImg == null){
                    se = shopService.modifyShop(shop, null);
                }else {
                    se = shopService.modifyShop(shop, shopImg);
                }


                if (se.getState() == ShopStateEnum.SUCCESS.getState()) {
                    modelMap.put("success", true);
                } else {
                    modelMap.put("success", false);
                    modelMap.put("errMsg", se.getStateInfo());
                }


            } catch (RuntimeException e) {
                modelMap.put("success", false);
                modelMap.put("errMsg", e.toString());
                return modelMap;
            }

        } else {
            modelMap.put("success", false);
            modelMap.put("errMsg", "请输入店铺ID");
        }
        modelMap.put("success",true);
        modelMap.put("errMsg", "修改成功");
        return modelMap;
    }

    /**
     * 获得店铺信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getshoplist", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> list(HttpServletRequest request) {
        Map<String, Object> modelMap = new HashMap<String, Object>();
        PersonInfo user = new PersonInfo();
        user.setUserId(8);
        user.setName("test");
        request.getSession().setAttribute("user",user);
        user = (PersonInfo) request.getSession().getAttribute("user");
        int employeeId = user.getUserId();
        try {
            ShopExecution shopList = shopService.getByEmployeeId(employeeId);
            List<Shop> list = shopList.getShopList();
            modelMap.put("shopList", list);
            modelMap.put("state",shopList.getState());
            modelMap.put("stateinfo",shopList.getStateInfo());
            modelMap.put("count",shopList.getCount());
            modelMap.put("user", user);
            modelMap.put("success", true);
            // 列出店铺成功之后，将店铺放入session中作为权限验证依据，即该帐号只能操作它自己的店铺
            request.getSession().setAttribute("shopList", list);
        } catch (Exception e) {
            e.printStackTrace();
            modelMap.put("success", false);
            modelMap.put("errMsg", e.toString());
        }
        return modelMap;
    }
}
