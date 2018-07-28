package com.hmb.util;

import java.io.File;

public class PathUtil {
    private static String seperator = System.getProperty("file.separator");

    static  String getImgBasePath(){
        String os = System.getProperty("os.name");
        String basePath = "";
        if(os.toLowerCase().startsWith("win")){
            basePath = "D:/images";
        }else {
            basePath = "/home/xiangze/image/";
        }
        basePath = basePath.replace("/",seperator);
        return basePath;
    }
    public  static String getShopImagePath(Integer shopId){
        String shopImagePathBuilder = "/upload/images/item/shop/" +
                shopId +
                "/";
        return shopImagePathBuilder.replace("/",
                seperator);
    }

    /**
     * 删除更新之前的路径
     * storePath是文件的路径还是目录的路径
     * 如果storePath是文件路径则删除
     * 如果storePath是目录路径则删除该目录下的所有文件
     * @param storePath
     */
    public static void deleteFile(String storePath) {
        File file = new File(getImgBasePath() + storePath);
        if (file.exists()) {
            if (file.isDirectory()) {
                File files[] = file.listFiles();
                for (int i = 0; i < files.length; i++) {
                    files[i].delete();
                }
            }
            file.delete();
        }
    }

    public static String getPersonInfoImagePath() {
        String personInfoImagePath = "/upload/images/item/personinfo/";
        personInfoImagePath = personInfoImagePath.replace("/", seperator);
        return personInfoImagePath;
    }
}
