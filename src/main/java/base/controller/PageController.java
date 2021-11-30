package base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 页面控制器
 *
 * @author hui
 * @date 2021-07-29 09:12:38
 */
@Controller
public class PageController {

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    /**
     * 登录页面
     *
     * @return 页面
     */
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    /**
     * 系统首页仪表盘
     *
     * @return 页面
     */
    @GetMapping("/home")
    public String home() {
        return "home";
    }

    /**
     * 菜单管理页面
     *
     * @return 页面
     */
    @GetMapping("/menu")
    public String menuList() {
        return "menu/list";
    }

    @GetMapping("/menu/add")
    public String menuAdd() {
        return "menu/add";
    }

    @GetMapping("/menu/edit")
    public String menuEdit() {
        return "menu/edit";
    }

    /**
     * 角色管理页面
     *
     * @return 页面
     */
    @GetMapping("/role")
    public String roleList() {
        return "role/list";
    }

    @GetMapping("/role/add")
    public String roleAdd() {
        return "role/add";
    }

    @GetMapping("/role/edit")
    public String roleEdit() {
        return "role/edit";
    }

    /**
     * 用户管理页面
     *
     * @return 页面
     */
    @GetMapping("/user")
    public String userList() {
        return "user/list";
    }

    @GetMapping("/user/add")
    public String userAdd() {
        return "user/add";
    }

    @GetMapping("/user/edit")
    public String userEdit(Integer id, Model model) {
        model.addAttribute("id", id);
        return "user/edit";
    }
}
