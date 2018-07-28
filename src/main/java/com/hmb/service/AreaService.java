package com.hmb.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hmb.pojo.Area;

import java.io.IOException;
import java.util.List;


public interface AreaService {
    List<Area> getArealist() throws IOException;
}
