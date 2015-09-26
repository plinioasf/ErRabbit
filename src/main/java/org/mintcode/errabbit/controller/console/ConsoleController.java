package org.mintcode.errabbit.controller.console;

import org.mintcode.errabbit.core.log.dao.LogRepository;
import org.mintcode.errabbit.model.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Receive all logs on one page through web socket.
 * Created by soleaf on 15. 6. 7..
 */
@Controller
@RequestMapping(value = "/console")
public class ConsoleController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    LogRepository logRepository;

    // Main UI
    @RequestMapping(value = "main")
    public String main(Model model){
        try{
            Page<Log> page = logRepository.findAll(new PageRequest(0, 5, new Sort(Sort.Direction.DESC, "_id")));
            model.addAttribute("preload", page);
            return "/console/main";
        }
        catch (Exception e){
            e.printStackTrace();
            logger.error(e.getMessage(),e);
            // todo: make ErrorPage
            model.addAttribute("e",e);
            return "/console/main";
        }
    }

    // Extend login session call (Ajax)
    @RequestMapping(value = "session")
    @ResponseBody
    public String extendSession() {
        return  "ok";
    }

}
