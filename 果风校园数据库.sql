--Goods 商品表
create table goods(
goods_id int primary key auto_increment,        -- ID
goods_name varchar(20) not null unique,         -- 名称
goods_type varchar(20) not null,                -- 果茶 果捞 水果
goods_price double not null,                    -- 价格
goods_img varchar(50) not null,                  -- 商品图片
goods_sellCount int not null default 0          --商品销售数量
);

-- PlanByManager官方水果配送方案表
CREATE TABLE planbymanager(
    plan_id INT PRIMARY KEY AUTO_INCREMENT,     -- ID
    plan_name VARCHAR(50) NOT NULL UNIQUE,      -- 方案一
    plan_introduct VARCHAR(50) NOT NULL,        -- 每次配送一到两种水果
    plan_good VARCHAR(50) NOT NULL,             -- 原味水果捞
    plan_price VARCHAR(50) NOT NULL,            -- 15
    plan_img VARCHAR(50) NOT NULL,              -- 方案图片地址
    plan_important bool NOT NULL                -- 重要性
)

-- shipping_settings 配送设置表
CREATE TABLE shipping_settings(
  Settings_id INT PRIMARY KEY AUTO_INCREMENT,
  Settings_by VARCHAR(50) NOT NULL,
  Settings_times VARCHAR(50) NOT NULL,
  Settings_days VARCHAR(50) NOT NULL,
  Setting_clock_time VARCHAR(50) NOT NULL,
  Setting_clock BOOL NOT NULL
)

--address 收货地址
CREATE TABLE address(
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50) NOT NULL UNIQUE,   
    apartment VARCHAR(50) NOT NULL, 
    phone VARCHAR(50) NOT NULL,
    school VARCHAR(50) NOT NULL,
    dormitory VARCHAR(50) NOT NULL
)

--ordertable 订单 
CREATE TABLE ordertable(
    order_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,   
    order_goods VARCHAR(50) NOT NULL,
    order_money VARCHAR(50) NOT NULL,
    order_time VARCHAR(50) NOT NULL,
    order_position VARCHAR(50) NOT NULL,
    order_phone VARCHAR(50) NOT NULL,
    order_status varchar(10)
)

--users 用户表
CREATE TABLE userstable(
    id INT PRIMARY KEY AUTO_INCREMENT,             -- id
    user_id VARCHAR(50) NOT NULL,     -- 用户open-id
    user_level varchar(8) not null default 0,   -- 用户等级
)