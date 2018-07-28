$(function () {
    var shopId =getQueryString("shopId");
    var shopInfoUrl = '/shopadmin/getshopmanagementinfo?shopId='+shopId;
    $.get(shopInfoUrl,function (data) {
        if(data.redirect){
            window.location.href = data.url;
        }else {
            if(data.shopId != undefined && data.shopId != null){
                shopId = data.shopId;
            }
            $('#shopinfo').attr('href','/shop/registershop?shopId='+shopId);
            $('#productcategorymanage').attr('href','/shop/productcategorymanage?shopId='+shopId);
        }
    })
});