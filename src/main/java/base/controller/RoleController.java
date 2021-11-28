package base.controller;

import base.bean.Result;
import base.bean.RetCode;
import base.dao.RoleDao;
import base.entity.Role;
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
 * 角色管理控制器
 *
 * @author hui
 * @date 2021-07-29 09:22:32
 */
@RestController
@RequestMapping("/role")
public class RoleController {

    @Resource
    private RoleDao roleDao;

    /**
     * 查询所有角色
     *
     * @param page  页码
     * @param limit 条数
     * @return 统一返回值JSON
     */
    @GetMapping("/list")
    public Result list(Integer page, Integer limit) {
        Pageable pageable = PageRequest.of(page - 1, limit);
        Page<Role> rolePage = roleDao.findAll(pageable);
        return new Result(RetCode.OK, rolePage.getContent(), rolePage.getTotalElements());
    }

    /**
     * 添加/修改角色
     *
     * @param role Role对象
     * @return 统一返回值JSON
     */
    @PostMapping("/save")
    public Result save(Role role) {
        roleDao.save(role);
        return new Result(RetCode.OK);
    }

    /**
     * 根据ID删除角色
     *
     * @param id 角色ID
     * @return 统一返回值JSON
     */
    @PostMapping("/delete")
    public Result delete(Integer id) {
        roleDao.deleteById(id);
        return new Result(RetCode.OK);
    }

}
