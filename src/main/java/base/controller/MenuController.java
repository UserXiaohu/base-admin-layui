package base.controller;

import base.bean.Result;
import base.bean.RetCode;
import base.dao.MenuDao;
import base.entity.Menu;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 菜单管理控制器
 *
 * @author hui
 * @date 2021-07-29 09:22:32
 */
@RestController
@RequestMapping("/menu")
public class MenuController {

    @Resource
    private MenuDao menuDao;

    /**
     * 查询所有菜单
     *
     * @param page  页码
     * @param limit 条数
     * @return 统一返回值JSON
     */
    @GetMapping("/list")
    public Result list(Integer page, Integer limit) {
        Pageable pageable = PageRequest.of(page - 1, limit);
        Page<Menu> menuPage = menuDao.findAll(pageable);
        return new Result(RetCode.OK, menuPage.getContent(), menuPage.getTotalElements());
    }

    /**
     * 添加/修改菜单
     *
     * @param menu Menu对象
     * @return 统一返回值JSON
     */
    @PostMapping("/save")
    public Result save(Menu menu) {
        menuDao.save(menu);
        return new Result(RetCode.OK);
    }

    /**
     * 根据ID删除菜单
     *
     * @param id 菜单ID
     * @return 统一返回值JSON
     */
    @PostMapping("/delete")
    public Result delete(Integer id) {
        menuDao.deleteById(id);
        return new Result(RetCode.OK);
    }

}
