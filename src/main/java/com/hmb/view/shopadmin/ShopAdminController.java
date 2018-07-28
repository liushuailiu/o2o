package com.hmb.view.shopadmin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@Controller
@RequestMapping(value = "/shop", method = { RequestMethod.GET,
        RequestMethod.POST })
public class ShopAdminController {

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    private String register() {
        return "shop/register";
    }

    @RequestMapping(value = "/registershop", method = RequestMethod.GET)
    private String shopEdit() {
        return "shop/registershop";
    }

    @RequestMapping(value = "/shoplist", method = RequestMethod.GET)
    private String shopList() {
        return "shop/shoplist";
    }

    @RequestMapping(value = "/shopmanage", method = RequestMethod.GET)
    private String shopManage() {
        return "shop/shopmanage";
    }

    @RequestMapping(value = "/productcategorymanage", method = RequestMethod.GET)
    private String productCategoryManage() {
        return "shop/productcategorymanage";
    }

    @RequestMapping(value = "/productedit", method = RequestMethod.GET)
    private String productmanage() {
        return "shop/productedit";
    }

    @RequestMapping(value = "/productmanage", method = RequestMethod.GET)
    private String productManage() {
        return "shop/productmanage";
    }
}
