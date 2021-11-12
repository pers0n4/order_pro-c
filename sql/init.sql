CALL drop_sequence_if_exists('reviews_seq');
CALL drop_sequence_if_exists('order_lines_seq');
CALL drop_sequence_if_exists('orders_seq');
CALL drop_sequence_if_exists('menus_seq');
CALL drop_sequence_if_exists('shops_seq');
CALL drop_sequence_if_exists('users_seq');

CALL drop_table_if_exists('reviews');
CALL drop_table_if_exists('order_lines');
CALL drop_table_if_exists('orders');
CALL drop_table_if_exists('menus');
CALL drop_table_if_exists('shops');
CALL drop_table_if_exists('users');

CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;
CREATE TABLE users
(
    user_id      NUMBER(8)    NOT NULL,
    username     VARCHAR2(20) NOT NULL UNIQUE,
    password     VARCHAR2(40) NOT NULL,
    phone_number VARCHAR2(14) NOT NULL UNIQUE,
    user_type    VARCHAR2(8) DEFAULT 'consumer' CHECK (user_type IN ('provider', 'consumer')),
    created_at   DATE        DEFAULT SYSDATE,
    CONSTRAINT user_pk PRIMARY KEY (user_id)
);

CREATE SEQUENCE shops_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;
CREATE TABLE shops
(
    shop_id  NUMBER(8)    NOT NULL,
    owner_id NUMBER(8)    NOT NULL,
    title    VARCHAR2(20) NOT NULL,
    CONSTRAINT shop_pk PRIMARY KEY (shop_id),
    CONSTRAINT shops_owner_fk FOREIGN KEY (owner_id) REFERENCES users (user_id)

);

CREATE SEQUENCE menus_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;
CREATE TABLE menus
(
    menu_id     NUMBER(8)    NOT NULL,
    shop_id     NUMBER(8)    NOT NULL,
    title       VARCHAR2(20) NOT NULL,
    price       NUMBER       NOT NULL,
    description VARCHAR2(100),
    CONSTRAINT menu_pk PRIMARY KEY (menu_id),
    CONSTRAINT menus_shop_fk FOREIGN KEY (shop_id) REFERENCES shops (shop_id)
);

CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;
CREATE TABLE orders
(
    order_id   NUMBER(8) NOT NULL,
    user_id    NUMBER(8) NOT NULL,
    shop_id    NUMBER(8) NOT NULL,
    menu_id    NUMBER(8) NOT NULL,
    ordered_at DATE DEFAULT SYSDATE,
    CONSTRAINT order_pk PRIMARY KEY (order_id),
    CONSTRAINT orders_user_fk FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT orders_shop_fk FOREIGN KEY (shop_id) REFERENCES shops (shop_id),
    CONSTRAINT orders_menu_fk FOREIGN KEY (menu_id) REFERENCES menus (menu_id)
);

CREATE SEQUENCE order_lines_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;
CREATE TABLE order_lines
(
    order_line_id NUMBER(8) NOT NULL,
    order_id      NUMBER(8) NOT NULL,
    menu_id       NUMBER(8) NOT NULL,
    quantity      NUMBER(4) NOT NULL,
    CONSTRAINT order_line_pk PRIMARY KEY (order_line_id),
    CONSTRAINT order_lines_order_fk FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT order_lines_menu_fk FOREIGN KEY (menu_id) REFERENCES menus (menu_id)
);

CREATE SEQUENCE reviews_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;
CREATE TABLE reviews
(
    review_id NUMBER(8) NOT NULL,
    order_id  NUMBER(8) NOT NULL,
    user_id   NUMBER(8) NOT NULL,
    rating    NUMBER(1) NOT NULL CHECK ( rating BETWEEN 1 AND 5),
    CONSTRAINT review_pk PRIMARY KEY (review_id),
    CONSTRAINT reviews_order_fk FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT reviews_user_fk FOREIGN KEY (user_id) REFERENCES users (user_id)
);

COMMIT;
