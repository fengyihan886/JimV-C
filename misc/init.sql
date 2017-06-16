# DROP DATABASE IF EXISTS jimv;
CREATE DATABASE IF NOT EXISTS jimv CHARACTER SET utf8;
USE jimv;


CREATE TABLE IF NOT EXISTS guest(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) NOT NULL,
    name VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    remark VARCHAR(255) NOT NULL DEFAULT '',
    os_template_id BIGINT UNSIGNED NOT NULL,
    create_time BIGINT UNSIGNED NOT NULL,
    -- 运行时的状态用 status;
    status TINYINT UNSIGNED NOT NULL DEFAULT 0,
    on_host VARCHAR(128) NOT NULL DEFAULT '',
    cpu TINYINT UNSIGNED NOT NULL,
    memory INT UNSIGNED NOT NULL,
    ip CHAR(15) NOT NULL,
    network VARCHAR(64) NOT NULL,
    manage_network VARCHAR(64) NOT NULL,
    vnc_port INT UNSIGNED NOT NULL,
    vnc_password VARCHAR(255) NOT NULL,
    xml TEXT NOT NULL,
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;

ALTER TABLE guest ADD INDEX (uuid);
ALTER TABLE guest ADD INDEX (name);
ALTER TABLE guest ADD INDEX (on_host);
ALTER TABLE guest ADD INDEX (ip);


CREATE TABLE IF NOT EXISTS guest_migrate_info(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) NOT NULL,
    type TINYINT UNSIGNED NOT NULL DEFAULT 0,
    time_elapsed BIGINT UNSIGNED NOT NULL DEFAULT 0,
    time_remaining BIGINT UNSIGNED NOT NULL DEFAULT 0,
    data_total BIGINT UNSIGNED NOT NULL DEFAULT 0,
    data_processed BIGINT UNSIGNED NOT NULL DEFAULT 0,
    data_remaining BIGINT UNSIGNED NOT NULL DEFAULT 0,
    mem_total BIGINT UNSIGNED NOT NULL DEFAULT 0,
    mem_processed BIGINT UNSIGNED NOT NULL DEFAULT 0,
    mem_remaining BIGINT UNSIGNED NOT NULL DEFAULT 0,
    file_total BIGINT UNSIGNED NOT NULL DEFAULT 0,
    file_processed BIGINT UNSIGNED NOT NULL DEFAULT 0,
    file_remaining BIGINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;

ALTER TABLE guest_migrate_info ADD INDEX (uuid);


CREATE TABLE IF NOT EXISTS disk(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    uuid CHAR(36) NOT NULL,
    label VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    size INT UNSIGNED NOT NULL,
    sequence TINYINT NOT NULL,
    format CHAR(16) NOT NULL DEFAULT 'qcow2',
    -- 实例固有的状态用 state;
    state TINYINT UNSIGNED NOT NULL DEFAULT 0,
    guest_uuid CHAR(36) NOT NULL,
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;

ALTER TABLE disk ADD INDEX (size);
ALTER TABLE disk ADD INDEX (guest_uuid);


CREATE TABLE IF NOT EXISTS os_template(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    label VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    icon VARCHAR(255) NOT NULL,
    os_init_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS os_init(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    remark TEXT NOT NULL DEFAULT '',
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS os_init_write(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    os_init_id BIGINT UNSIGNED NOT NULL,
    path VARCHAR(255) NOT NULL,
    content TEXT NOT NULL DEFAULT '',
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS config(
    id BIGINT UNSIGNED NOT NULL DEFAULT 1,
    glusterfs_volume VARCHAR(255) NOT NULL,
    storage_path VARCHAR(255) NOT NULL,
    vm_network VARCHAR(255) NOT NULL,
    vm_manage_network VARCHAR(255) NOT NULL,
    start_ip CHAR(15) NOT NULL,
    end_ip CHAR(15) NOT NULL,
    start_vnc_port INT UNSIGNED NOT NULL,
    netmask CHAR(15) NOT NULL,
    gateway CHAR(15) NOT NULL,
    dns1 CHAR(15) NOT NULL DEFAULT '223.5.5.5',
    dns2 CHAR(15) NOT NULL DEFAULT '8.8.8.8',
    rsa_private text NOT NULL DEFAULT '',
    rsa_public text NOT NULL DEFAULT '',
    PRIMARY KEY (id))
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS log(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    type TINYINT UNSIGNED NOT NULL,
    timestamp BIGINT UNSIGNED NOT NULL,
    host CHAR(15),
    message VARCHAR(255) NOT NULL DEFAULT '',
    PRIMARY KEY (id))
    ENGINE=Innodb
    DEFAULT CHARSET=utf8;

ALTER TABLE log ADD INDEX (host);

