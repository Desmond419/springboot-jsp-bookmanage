use book_manage_db;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS user;
CREATE TABLE user
(
  id                    VARCHAR(255) NOT NULL PRIMARY KEY COMMENT '用户id',
  username              VARCHAR(255) NOT NULL COMMENT '用户名',
  password              VARCHAR(255) NOT NULL COMMENT '密码',
  role                  VARCHAR(255) DEFAULT 'user' NOT NULL COMMENT '角色'
);
INSERT INTO user(id, username, password, role)
values
('1','张三', '$2a$10$/PDVtIkLEmjjR.3GrLWg6OwBnV7Z1xXgmR11O1m1K6AMcAeqPqrra', 'admin'), -- password: 123
('2','李四', '$2a$10$/PDVtIkLEmjjR.3GrLWg6OwBnV7Z1xXgmR11O1m1K6AMcAeqPqrra', 'user'); -- password: 123

-- ----------------------------
-- Table structure for book_type
-- ----------------------------
DROP TABLE IF EXISTS book_type;
CREATE TABLE book_type
(
  id                        VARCHAR(255) NOT NULL PRIMARY KEY COMMENT '类型id',
  type_name                 VARCHAR(255) NOT NULL COMMENT '名字',
  description               VARCHAR(255) COMMENT '描述'
);
INSERT INTO book_type(id, type_name)
values
('1','小说'),
('2','计算机科学'),
('3','漫画');

-- ----------------------------
-- Table structure for book_info
-- ----------------------------
DROP TABLE IF EXISTS book_info;
CREATE TABLE book_info
(
  id                        VARCHAR(255) NOT NULL PRIMARY KEY COMMENT '书籍id',
  book_type_id              VARCHAR(255) NOT NULL COMMENT '书籍类型id',
  name                      VARCHAR(255) NOT NULL COMMENT '名字',
  author                    VARCHAR(255) NOT NULL COMMENT '作者',
  price                     VARCHAR(255) COMMENT '价格',
  description               VARCHAR(255) COMMENT '描述',
  img                       VARCHAR(255) COMMENT '照片',
  isBorrow                  INTEGER DEFAULT 0 COMMENT '是否已借阅（0否 1已）',

  FOREIGN KEY (book_type_id) REFERENCES book_type (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO book_info(id, book_type_id, name, author, price, description)
values
('1','1', '西游记', '吴承恩', '60', '《西游记》中国古典四大名著之一，是中国古代一部浪漫主义长篇神魔小说，作者吴承恩，成书于16世纪明朝中叶，主要描写了唐僧、孙悟空、猪悟能、沙悟净师徒四人去西天'),
('2','1', '红楼梦', '曹雪芹', '49.9', '《红楼梦》，是中国古代章回体长篇小说，中国古典四大名著之首。其通行本共120回，一般认为前80回是清代作家曹雪芹所著，后40回作者为无名氏，由高鹗、程伟元整理'),
('3','3', '火影忍者', '岸本齐史', '27.9', '这是一个忍者的世界。在这里，忍者的职业是所有少年们的梦想！ 主人公鸣人因为身上封印着邪恶的九尾狐，无父无母的他受尽了村人的冷落。无可奈何之下，鸣人拼命用各种恶作剧试图吸引大家的注意力。在依卡鲁老师的关心下，鸣人始终保持着乐观的精神。'),
('4','2', 'Java程序设计', '耿祥义', '79.9', '《Java实用教程》可作为高等院校相关专业的教材');

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS borrow;
CREATE TABLE borrow
(
  id                    VARCHAR(255) NOT NULL PRIMARY KEY COMMENT '地址id',
  user_id               VARCHAR(255) NOT NULL COMMENT '用户id',
  book_id               VARCHAR(255) NOT NULL COMMENT '书籍id',
  borrow_time           VARCHAR(255) COMMENT '借阅时间',
  return_time           VARCHAR(255) COMMENT '归还时间',

  FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (book_id) REFERENCES book_info (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO borrow(id, user_id, book_id, borrow_time, return_time)
values
('1','1','1', '2023-12-13 19:52:23', '2023-12-20 19:52:23'),
('2','2','2', '2023-12-08 13:25:59', '2023-12-15 13:25:59');

SET FOREIGN_KEY_CHECKS = 1;