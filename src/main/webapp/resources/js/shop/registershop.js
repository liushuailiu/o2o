$(function() {
    var shopId = getQueryString('shopId');

    var isEdit = shopId ? true : false;
    var shopInfoUrl = '/shopadmin/getshopbyid?shopId=' + shopId;
    var initUrl = '/shopadmin/getshopinitinfo';
    var registerShopUrl = '/shopadmin/registershop';
    var modifyShopUrl = '/shopadmin/modifyshop';

    if (!isEdit) {
        getCategory();
    }else {
        getInfo(shopId);
    }


    function getInfo(shopId) {
        $.getJSON(shopInfoUrl, function(data) {
            if (data.success) {
                var shop = data.shop;
                $('#shop-name').val(shop.shopName);
                $('#shop-addr').val(shop.shopAddr);
                $('#shop-phone').val(shop.phone);
                $('#shop-desc').val(shop.shopDesc);
                var shopCategory = '<option data-id="'
                    + shop.shopCategory.shopCategoryId + '" selected>'
                    + shop.shopCategory.shopCategoryName + '</option>';
                var tempAreaHtml = '';
                data.areaList.map(function(item, index) {
                    tempAreaHtml += '<option data-id="' + item.areaId + '">'
                        + item.areaName + '</option>';
                });
                $('#shop-category').html(shopCategory);
                $('#shop-category').attr('disabled','disabled');
                $('#area').html(tempAreaHtml);
                $('#area').attr('data-id',shop.areaId);
            }
        });
    }

    function getCategory() {
        $.get(initUrl,null,function(data) {
            if (data.success) {
                var tempHtml = '';
                var tempAreaHtml = '';
                data.shopCategoryList.map(function(item, index) {
                    tempHtml += '<option data-id="' + item.shopCategoryId
                        + '">' + item.shopCategoryName + '</option>';
                });
                data.areaList.map(function(item, index) {
                    tempAreaHtml += '<option data-id="' + item.areaId + '">'
                        + item.areaName + '</option>';
                });
                $('#shop-category').html(tempHtml);
                // $('#shop-category').removeAttr('disabled');
                $('#area').html(tempAreaHtml);
            }
        });
    }



    $('#submit').click(function() {
        var shop = {};
        if(isEdit){
            shop.shopId = shopId;
        }
        shop.shopName = $('#shop-name').val();
        shop.shopAddr = $('#shop-addr').val();
        shop.phone = $('#shop-phone').val();
        shop.shopDesc = $('#shop-desc').val();


        shop.shopCategoryId = $('#shop-category').find('option').not(function() {
            return !this.selected;
        }).data('id');

        shop.areaId = $('#area').find('option').not(function() {
            return !this.selected;
        }).data('id');


        var shopImg = $("#shop-img")[0].files[0];
        var formData = new FormData();


        formData.append('shopImg', shopImg);
        formData.append('shopStr', JSON.stringify(shop));
        var verifyCodeActual = $('#j_captcha').val();
        if (!verifyCodeActual) {
            layer.open({
                content: "请输入验证码"
                ,skin: 'msg'
                ,time: 2 //2秒后自动关闭
            });
            return;
        }
        formData.append("verifyCodeActual", verifyCodeActual);
        $.ajax({
            url : (isEdit?modifyShopUrl:registerShopUrl),
            type : 'POST',
            // contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data : formData,
            contentType : false,
            processData : false,
            cache : false,
            success : function(data) {
                if (data.success) {
                    layer.open({
                        content: "添加成功"
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                        ,yes: function(){
                            window.location.href="shoplist";
                        }
                    });
                    window.location.href="shoplist";
                } else {
                    layer.open({
                        content: "添加失败"
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                    });
                    $('#captcha_img').click();
                }
            }
        });
    });

});