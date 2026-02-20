-- CREAR BASE DE DATOS
DROP DATABASE IF EXISTS shopping_cart;
CREATE DATABASE shopping_cart;

-- USAR LA BASE DE DATOS
USE shopping_cart;

-- CREAR TABLA DE CATEGORÍA
CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    status INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL
);

-- CREAR TABLA DE PRODUCTO
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,    
    status INT NOT NULL,
    category_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id)
);

-- CREAR TABLA DE INVENTARIO
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    stock INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,        
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- CREAR TABLA DE PERSONA
CREATE TABLE person (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    adress VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    status INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL
);

-- CREAR TABLA DE ROLES
CREATE TABLE role (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    status INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL
);

-- CREAR TABLA DE MODULUS
CREATE TABLE module (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    status INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL
);

-- CREAR TABLA DE VISTAS DEL SISTEMA
CREATE TABLE system_view (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    module_id INT NOT NULL,
    status INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (module_id) REFERENCES module(id)
);

-- CREAR TABLA DE PERMISOS DE LOS ROLES
CREATE TABLE role_permission (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    role_id INT NOT NULL,
    module_id INT NOT NULL,
    can_create BOOLEAN NOT NULL,
    can_read BOOLEAN NOT NULL,
    can_update BOOLEAN NOT NULL,
    can_delete BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (role_id) REFERENCES role(id),
    FOREIGN KEY (module_id) REFERENCES module(id)
);

-- CREAR TABLA DE USUARIOS
CREATE TABLE user ( 
    id INT AUTO_INCREMENT PRIMARY KEY,    
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    person_id INT NOT NULL,
    role_id INT NOT NULL,
    status INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- BUSSINES LOGIC
CREATE TABLE shopping_cart (
    id INT AUTO_INCREMENT PRIMARY KEY,    
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE shopping_cart_item (
    id INT AUTO_INCREMENT PRIMARY KEY,        
    inventory_id INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    total_discount DECIMAL(10, 2) NOT NULL,
    total_tax DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    shopping_cart_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (shopping_cart_id) REFERENCES shopping_cart(id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(id)
);