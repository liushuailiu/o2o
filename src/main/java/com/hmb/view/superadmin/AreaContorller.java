package com.hmb.view.superadmin;



import com.hmb.pojo.Area;
import com.hmb.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/superadmin")
public class AreaContorller {
    @Autowired
    private AreaService areaService;
    @GetMapping("/get")
    public Map<String,Object> listArea(){
        Map<String,Object> map = new HashMap<>();
        List<Area> area = null;
        try {
            area = areaService.getArealist();
        }catch (Exception e){
            map.put("success",false);
            map.put("msg",e.getMessage());
        }

        map.put("success",true);
        map.put("msg",area);
        return map;
    }
}
