package base.controller;

import base.bean.Result;
import base.bean.RetCode;
import base.dao.UserDao;
import base.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户管理控制器
 *
 * @author hui
 * @date 2021-07-29 09:22:32
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserDao userDao;

    /**
     * 查询所有用户
     *
     * @param page  页码
     * @param limit 条数
     * @return 统一返回值JSON
     */
    @GetMapping("/list")
    public Result list(Integer page, Integer limit) {
        Pageable pageable = PageRequest.of(page - 1, limit);
        Page<User> userPage = userDao.findAll(pageable);
        List<User> users = userPage.getContent();
        Long count = userPage.getTotalElements();
        return new Result(RetCode.LIST_SUCCESS, users, count);
    }

    /**
     * 根据ID查询用户
     *
     * @param id 用户ID
     * @return 统一返回值JSON
     */
    @GetMapping("/get")
    public Result get(Integer id) {
        User user = userDao.getById(id);
        System.out.println(user);
        return new Result(RetCode.USER_GET_SUCCESS, user);
    }

    /**
     * 添加/修改用户
     *
     * @param user User对象
     * @return 统一返回值JSON
     */
    @PostMapping("/save")
    public Result save(User user) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String password = passwordEncoder.encode(user.getPassword());
        user.setPassword(password);
        userDao.save(user);
        return new Result(RetCode.USER_SAVE_SUCCESS);
    }

    /**
     * 根据ID删除用户
     *
     * @param id 用户ID
     * @return 统一返回值JSON
     */
    @DeleteMapping("/delete")
    public Result delete(Integer id) {
        userDao.deleteById(id);
        return new Result(RetCode.OK);
    }
}
