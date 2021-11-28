package base.config;

/**
 * 权限列表
 *
 * @author hui
 * @date 2021-11-28 19:02:17
 */
public class AuthConstant {

    /**
     * 超级管理员权限
     */
    public static final String[] ADMIN = {
            "/menu/**",
            "/role/**",
            "/user/**"
    };

    /**
     * 静态资源
     */
    public static final String[] STATIC = {
            "/css/**",
            "/js/**",
            "/images/**",
            "/lib/**"
    };
}
