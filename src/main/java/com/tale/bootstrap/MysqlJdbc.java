package com.tale.bootstrap;

import com.blade.mvc.Const;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.stream.Collectors;

/**
 * Mysql 数据库操作
 * <p>
 * Created by uaholic on 2019/12/25.
 */
@Slf4j
@NoArgsConstructor
public final class MysqlJdbc {

    public static final String DB_NAME = "tale";
    public static String DB_PATH;
    public static String DB_SRC;
    public static String DB_USERNAME;
    public static String DB_PASSWORD;

    static {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (Exception e) {
            log.error("load sqlite driver error", e);
        }
    }

    /**
     * 测试连接并导入数据库
     */
    public static void importSql(boolean devMode) {
        try {

            DB_PATH = Const.CLASSPATH + File.separatorChar + DB_NAME;
            DB_SRC = "jdbc:mysql://" + DB_PATH;
            DB_USERNAME="root";
            DB_PASSWORD="study";

            if (devMode) {
                DB_PATH = "207.148.106.40:3306"+ "/" + DB_NAME;
                DB_SRC = "jdbc:mysql://" + DB_PATH;
            }

            log.info("blade dev mode: {}", devMode);
            log.info("load sqlite database path [{}]", DB_PATH);
            log.info("load sqlite database src [{}]", DB_SRC);

            Connection con       = DriverManager.getConnection(DB_SRC,DB_USERNAME,DB_PASSWORD);
            Statement  statement = con.createStatement();
            ResultSet  rs        = statement.executeQuery("SELECT 1");
            rs.next();
            int        count     = rs.getInt(1);
            // TODO: 2019-12-25 这里有问题 原有逻辑是用来判断是否已经建表
            if (count == 0) {
                String            cp  = MysqlJdbc.class.getClassLoader().getResource("").getPath();
                InputStreamReader isr = new InputStreamReader(new FileInputStream(cp + "schema.sql"), "UTF-8");

                String sql = new BufferedReader(isr).lines().collect(Collectors.joining("\n"));
                int    r   = statement.executeUpdate(sql);
                log.info("initialize import database - {}", r);
            }
            rs.close();
            statement.close();
            con.close();
            log.info("database path is: {}", DB_PATH);
        } catch (Exception e) {
            log.error("initialize database fail", e);
        }
    }

}