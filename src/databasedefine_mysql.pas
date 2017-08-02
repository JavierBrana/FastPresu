unit databasedefine_MySql;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const

  //------------ informción básica de la databse -----------------------------
  tDBUsers_MySQL = 'CREATE TABLE USERS ('              +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '     +
    'NAME VARCHAR(60) COMMENT "Name", '                         +  // 03. Nombre
    'SURNAME VARCHAR(60) COMMENT "Surname", '                      +  // 04. Apellidos
    'USERNAME VARCHAR(60) NOT NULL UNIQUE  COMMENT "User Name", '     +  // 05. Forma
    'PASSWORD VARCHAR(60) COMMENT "PassWord", '                     +  // 05. Forma
    'USERTYPE INTEGER, '                         +  // 05. Forma
    'PERMITS VARCHAR(350), '                     +  // 05. Forma
    'LOCKED BOOLEAN, '                           +  // 05. Forma
    'PICTURE BLOB, '                            +  // 05. Forma
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP,'                    +  // 5.  Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';


  //------------ informción básica de la databse -----------------------------
  tDBUsersConfig_MySQL = 'CREATE TABLE USERCONFIG ('                   +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '                          +
    'USER_ID INTEGER, '                                                +
    'NAME VARCHAR(60) COMMENT "Name", '                         +  // 03. Nombre
    'SURNAME VARCHAR(60) COMMENT "Surname", '                      +  // 04. Apellidos
    'USERNAME VARCHAR(60) NOT NULL UNIQUE  COMMENT "User Name", '     +  // 05. Forma
    'PASSWORD VARCHAR(60) COMMENT "PassWord", '                     +  // 05. Forma
    'USERTYPE INTEGER, '                         +  // 05. Forma
    'PERMITS VARCHAR(350), '                     +  // 05. Forma
    'LOCKED BOOLEAN, '                           +  // 05. Forma
    'PICTURE BLOB, '                            +  // 05. Forma
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP,'                    +  // 5.  Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //------------ informción básica de la databse -----------------------------
  tDBInfo_MySQL = 'CREATE TABLE DBINFO ('              +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '     +
    'VERSION VARCHAR(10) NOT NULL, '             +
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP '   +   // 25. Fecha de creación
    ');';

  //--------------- BASE DE DATOS DE EMPRESAS, LISTADO ------------------------
  tEmpresas_MySQL = 'CREATE TABLE IF NOT EXISTS ENTERPRISES (' +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '                    +  // 0.  ID
    'NAME VARCHAR(100) NOT NULL, '                               +  // 1.  Nombre de la empresa
    'DBNAME VARCHAR(100) NOT NULL, '                             +  // 1.  Nombre de la empresa
    'ID_NUMBER VARCHAR(9) NOT NULL, '                            +  // 2.  CIF
    'LOGO BLOB, '                                                +  // 4.  Logo1
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP,'              +  // 5.  Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //----------------------- INFORMACION DE LA EMPRESA -------------------------
  tEmpresaInfo_MySQL = 'CREATE TABLE ENTERPRISESINFO (' +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, ' +   // 0.  ID
    'NAME VARCHAR(100) NOT NULL, ' +              // 1.  Nombre de la empresa
    'ID_NUMBER VARCHAR(10) NOT NULL, ' +              // 2.  CIF

    'ADDRESS1	VARCHAR(40), ' +                    // 4.  Línea Dirección 1
    'ADDRESS2	VARCHAR(40), ' +                     // 5.  Línea Dirección 2
    'POSTCODE	VARCHAR(9), ' +                    // 6.  Código postal
    'CITY	VARCHAR(80), ' +                    // 7.  Ciudad
    'PROVINCE VARCHAR(80), ' +                    // 8.  Provincia
    'COUNTRY VARCHAR(80), ' +                    // 9.  Pais
    'PHONE VARCHAR(20), ' +                    // 10. Teléfono
    'MOBILE VARCHAR(20), ' +                    // 11. Movil
    'FAX VARCHAR(20), ' +                    // 12. Fax
    'EMAIL VARCHAR(60), ' +                    // 13. e-mail
    'WEB VARCHAR(60), ' +                    // 14. Web

    'COMMUNITY_CIF VARCHAR(9), ' +                    // 15. CIF Comunitario
    'IAE VARCHAR(9), ' +                    // 16. IAE
    'CNAE VARCHAR(9), ' +                    // 17. CNAE
    'DCNAE VARCHAR(9), ' +                    // 18. Descripción CNAE

    'BANK_NAME VARCHAR(80),' +                    // 19. Banco
    'IBAN VARCHAR(28), ' +                    // 20. IBAN
    'BIC_SWIFT VARCHAR(11), ' +                    // 21. BIC/SWIFT

    'LOGO1 BLOB, ' +                    // 22. Logo1
    'LOGO2 BLOB, ' +                    // 23. Logo2
    'LOGO3 BLOB, ' +                    // 24. Logo3
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //----------------------- CLIENTE -------------------------------------------
  tCliente_MySQL = 'CREATE TABLE CUSTOMER (' +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, ' +  // 0.  ID
    'CODE VARCHAR(10) NOT NULL, ' +  // 1.  Code
    'FORM VARCHAR(25), ' +  // 2.  Forma
    'ID_NUMBER VARCHAR(9) NOT NULL, ' +   // 3.  CIF
    'NAME VARCHAR(60) NOT NULL, ' +   // 4.  Nombre del cliente
    'FAMILY VARCHAR(25), ' +    // 5.  Familia de clientes

    // Dirección del cliente:
    'CONTACT VARCHAR(60), ' +  // 6.  Contacto normal
    'ADDRESS1 VARCHAR(40), ' +  // 7.  Línea Dirección 1
    'ADDRESS2 VARCHAR(40), ' +  // 8.  Línea Dirección 2
    'POSTCODE VARCHAR(9), ' +  // 9.  Código postal
    'CITY VARCHAR(80), ' +  // 10. Ciudad
    'PROVINCE VARCHAR(80), ' +  // 11. Provincia
    'COUNTRY_ID VARCHAR(2), ' +  // 12. Diminutivo del pais
    'COUNTRY VARCHAR(80), ' +  // 13. Pais
    'PHONE VARCHAR(20), ' +  // 14. Teléfono
    'MOBILE VARCHAR(20), ' +  // 15. Movil
    'FAX VARCHAR(20), ' +  // 16. Fax
    'EMAIL VARCHAR(60), ' +  // 17. e-mail

    // Dirección de facturación:
    'BILLING_CONTACT VARCHAR(60), ' +  // 18. Contacto de facturación
    'BILLING_ADDRESS1 VARCHAR(40), ' +  // 19. Línea Dirección 1
    'BILLING_ADDRESS2 VARCHAR(40), ' +  // 20. Línea Dirección 2
    'BILLING_POSTCODE VARCHAR(9), ' +  // 21. CP
    'BILLING_CITY VARCHAR(80), ' +  // 22. Ciudad
    'BILLING_PROVINCE VARCHAR(80), ' +  // 23. Provincia
    'BILLING_COUNTRY_ID VARCHAR(2), ' +  // 24. Diminutivo del Pais
    'BILLING_COUNTRY VARCHAR(80), ' +  // 25. Pais
    'BILLING_PHONE VARCHAR(20), ' +  // 26. Teléfono
    'BILLING_MOBILE VARCHAR(20), ' +  // 27. Movil
    'BILLING_FAX VARCHAR(20), ' +  // 28. Fax
    'BILLING_EMAIL VARCHAR(60), ' +  // 29. e-mail

    'WEB VARCHAR(60), ' +  // 30. Web

    // Bancos:
    'BANK_NAME_0 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_0 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_0 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_0 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'BANK_NAME_1 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_1 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_1 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_1 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'BANK_NAME_2 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_2 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_2 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_2 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'BANK_NAME_3 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_3 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_3 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_3 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'PAYMENT_METHOD VARCHAR(40), ' +  // 39. Forma de Pago
    'ACCOUNT VARCHAR(10), ' +  // 40. Cuenta de Contavilidad
    'LOGO BLOB, ' +  // 41. Imagen

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //----------------------- ELEMENTO ------------------------------------------
  tElemento_MySQL = 'CREATE TABLE ELEMENT (' +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, ' + // 0.  ID
    'CODE VARCHAR(20) NOT NULL UNIQUE, ' +  // 1.  Code
    'TYPE	VARCHAR(2) NOT NULL, ' +    // 2.  Tipo
    'TITLE VARCHAR(100) NOT NULL, ' +  // 3.  Resumen
    'DESCRIPTION BLOB, ' +  // 4.  Descripción
    'FAMILY_ID VARCHAR(9), ' +  // 5.  ID de Familia
    'UNIT_ID VARCHAR(9), ' +  // 6.  ID de Unidad

    'DATE_UPDATE DATETIME DEFAULT CURRENT_TIMESTAMP, ' +  // 7.  Fecha de la última modificación
    'REAL_PRICE	FLOAT, ' +  // 8.  PVP de compra
    'DISCOUNT FLOAT, ' +  // 9.  Descuento frente a PVP
    'PURCHASE_PRICE	FLOAT, ' +  // 10. Precio de compra
    'BENEFIT FLOAT, ' +  // 11. Beneficio respecto al PC
    'TAX FLOAT, ' +  // 12. IVA

    'BARCODE VARCHAR(20), ' +  // 13. Código de Barras
    'IMAGE BLOB, ' +  // 14. Imagen
    'STATE BOOLEAN DEFAULT FALSE, ' +  // 15. Elemento inactivo

    'MANUFACTURER VARCHAR(40), ' +    // 16. Fabricante o marca
    'GAMMA VARCHAR(40), ' +    // 17. Gama

    // Tamaño:
    'WEIGHT FLOAT, ' +  // 98. ID proveedor por defecto
    'HEIGHT FLOAT, ' +  // 98. ID proveedor por defecto
    'WIDTH FLOAT, ' +  // 98. ID proveedor por defecto
    'LENGHT FLOAT, ' +  // 98. ID proveedor por defecto

    // Proveedores:
    'SUPPLIER_ID_0 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_0 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_0 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_0 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_0 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_0 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_0 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_0	DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_1 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_1 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_1 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_1 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_1 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_1 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_1 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_1 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_2 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_2 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_2 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_2 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_2 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_2 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_2 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_2 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_3 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_3 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_3 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_3 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_3 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_3 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_3 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_3 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_4 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_4 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_4 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_4 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_4 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_4 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_4 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_4 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_5 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_5 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_5 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_5 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_5 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_5 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_5 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_5 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_6 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_6 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_6 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_6 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_6 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_6 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_6 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_6 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_7 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_7 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_7 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_7 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_7 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_7 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_7 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_7 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_8 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_8 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_8 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_8 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_8 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_8 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_8 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_8 DATETIME, ' + // 25. Fecha de actualización del precio

    'SUPPLIER_ID_9 VARCHAR(10), ' +    // 18. ID del proveedor
    'SUPPLIER_NAME_9 VARCHAR(60), ' +  // 19. Nombre del proveedor
    'SUPPLIER_REFERENCE_9 VARCHAR(20), ' +  // 20. Ref. del elemento que tiene el proveedor
    'SUPPLIER_REAL_PRICE_9 FLOAT, ' +  // 21. PVP
    'SUPPLIER_DISCOUNT_9 FLOAT, ' +  // 22. Descuento
    'SUPPLIER_PURCHASE_PRICE_9 FLOAT, ' +  // 23. Precio compra
    'SUPPLIER_MINIMUM_AMOUNT_9 FLOAT, ' + // 24. Cantidad mínima de pedido
    'SUPPLIER_DATE_UPDATE_9 DATETIME, ' + // 97. Fecha de actualización del precio

    'SUPPLIER_DEFAULT INTEGER, ' +  // 98. ID proveedor por defecto

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+

    ');';

  //------------ COMPOSICIÓN DE UNIDADES DE OBRA ------------------------------
  tElemComp_MySQL = 'CREATE TABLE ELEMENTCOMPOSITION (' +
    'NORDER INTEGER NOT NULL, ' + // 0. Orden del elemento
    'CODE VARCHAR(20) NOT NULL, ' +      // 1. ID de la Unidad de obra
    'ELEMENT_CODE VARCHAR(20) NOT NULL, ' +      // 2. ID del elemento
    'ELEMENT_AMOUNT FLOAT, ' +    // 3. Cantidad del elemento

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +    // 4. Fecha de su creación
    'CREATEDBY VARCHAR (100),' +

    'PRIMARY KEY(NORDER, CODE, ELEMENT_CODE));';

  //----------------------- PROVEEDORES ---------------------------------------
  tProveedor_MySQL = 'CREATE TABLE SUPPLIER (' +  //sup plier
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, ' +
    'CODE	VARCHAR(10) NOT NULL, '           +  // 01.  ID
    'FORM	VARCHAR(25), '                      +  // 02.  Forma
    'ID_NUMBER VARCHAR(9) NOT NULL, '              +   // 2.  CIF
    'NAME VARCHAR(60) NOT NULL, '             + // 3.  Nombre del priente
    'FAMILY	VARCHAR(25),'                      +

          // Dirección del cliente:
    'CONTACT VARCHAR(60), ' +  // 6.  Contacto normal
    'ADDRESS1 VARCHAR(40), ' +  // 7.  Línea Dirección 1
    'ADDRESS2 VARCHAR(40), ' +  // 8.  Línea Dirección 2
    'POSTCODE VARCHAR(9), ' +  // 9.  Código postal
    'CITY VARCHAR(80), ' +  // 10. Ciudad
    'PROVINCE VARCHAR(80), ' +  // 11. Provincia
    'COUNTRY_ID VARCHAR(2), ' +  // 12. Diminutivo del pais
    'COUNTRY VARCHAR(80), ' +  // 13. Pais
    'PHONE VARCHAR(20), ' +  // 14. Teléfono
    'MOBILE VARCHAR(20), ' +  // 15. Movil
    'FAX VARCHAR(20), ' +  // 16. Fax
    'EMAIL VARCHAR(60), ' +  // 17. e-mail

    // Dirección de facturación:
    'BILLING_CONTACT VARCHAR(60), ' +  // 18. Contacto de facturación
    'BILLING_ADDRESS1 VARCHAR(40), ' +  // 19. Línea Dirección 1
    'BILLING_ADDRESS2 VARCHAR(40), ' +  // 20. Línea Dirección 2
    'BILLING_POSTCODE VARCHAR(9), ' +  // 21. CP
    'BILLING_CITY VARCHAR(80), ' +  // 22. Ciudad
    'BILLING_PROVINCE VARCHAR(80), ' +  // 23. Provincia
    'BILLING_COUNTRY_ID VARCHAR(2), ' +  // 24. Diminutivo del Pais
    'BILLING_COUNTRY VARCHAR(80), ' +  // 25. Pais
    'BILLING_PHONE VARCHAR(20), ' +  // 26. Teléfono
    'BILLING_MOBILE VARCHAR(20), ' +  // 27. Movil
    'BILLING_FAX VARCHAR(20), ' +  // 28. Fax
    'BILLING_EMAIL VARCHAR(60), ' +  // 29. e-mail

    'WEB VARCHAR(60), ' +  // 30. Web

    // Bancos:
    'BANK_NAME_0 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_0 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_0 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_0 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'BANK_NAME_1 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_1 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_1 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_1 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'BANK_NAME_2 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_2 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_2 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_2 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'BANK_NAME_3 VARCHAR(60), ' +  // 31. Nombre
    'BANK_ADDRESS_3 VARCHAR(60), ' +  // 32. Dirección
    'IBAN_3 VARCHAR(28), ' +  // 37. IBAN
    'BIC_SWIFT_3 VARCHAR(11), ' +  // 38. BIC / SWIFT

    'PAYMENT_METHOD VARCHAR(40), ' +  // 39. Forma de Pago
    'ACCOUNT VARCHAR(10), ' +  // 40. Cuenta de Contavilidad
    'LOGO BLOB, ' +  // 41. Imagen

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)' +
    ');';

  //----------------------- FORMAS -------------------------------------------
  tForma_MySQL = 'CREATE TABLE FORM (' +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT,' +
    'DESCRIPTION VARCHAR(10) NOT NULL);';

  //----------------------- FAMILIAS DE PROVEEDORES ---------------------------
  tFamProv_MySQL = 'CREATE TABLE SUPPLIERFAMILIES (' +
    'ID VARCHAR(10) NOT NULL UNIQUE, ' +
    'DESCRIPTION VARCHAR(60) NOT NULL, ' +
    'PRIMARY KEY(ID));';

  //----------------------- FAMILIAS DE CLIENTES -----------------------------
  tFamCli_MySQL = 'CREATE TABLE CUSTOMERFAMILIES (' +
    'ID VARCHAR(10) NOT NULL UNIQUE, ' +
    'DESCRIPTION VARCHAR(60) NOT NULL, ' +
    'PRIMARY KEY(ID));';

  //----------------------- FAMILIAS DE ELEMENTOS ----------------------------
  tFamEle_MySQL = 'CREATE TABLE ELEMENTFAMILIES ('            +
    'ID VARCHAR(10) NOT NULL UNIQUE,'               +
    'DESCRIPTION	VARCHAR(60) NOT NULL, '             +
    'PRIMARY KEY(ID));';

  //----------------------- UNIDADES ------------------------------------------
  tUnidad_MySQL = 'CREATE TABLE UNIT ('            +
    'ID VARCHAR(10) NOT NULL UNIQUE,'                       +
    'DESCRIPTION	VARCHAR(60) NOT NULL, '             +
    'PRIMARY KEY(ID));';

  //---------------------- DOCUMENTOS DE VENTA --------------------------------
  tDocVenta_MySQL = 'CREATE TABLE SALEDOCUMENT ('           +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '               +  // 0.  ID
    'TYPE VARCHAR(2)	NOT NULL, '                         +  // 1.  Tipo de documento: PR - Presu, FA - Factura,
    'CODE VARCHAR(20) NOT NULL UNIQUE, '                    +  // 2.  ID documento
    'TITLE VARCHAR(100) NOT NULL, '                         +  // 3.  Nombre documento
    'CUSTOMER_CODE VARCHAR(10) NOT NULL, '                  +  // 4.  ID cliente
    'CUSTOMER_NAME VARCHAR(60) NOT NULL, '                  +  // 5.  Nombre cliente
    'PROJECT_CODE VARCHAR(10), '                            +  // 6.  ID del proyecto
    'PROJECT_TITLE VARCHAR(60), '                           +  // 6.  Nombre proveedor

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, '        +  // 7.  Fecha creación
    'VALIDTO DATETIME DEFAULT CURRENT_TIMESTAMP, '          +  // 8.  Valido hasta la fecha
    'DELIVERY_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, '    +  // 9.  Fecha de expedición

    'COST DOUBLE, '                                         +  // 10. Precio total Compra
    'PRICE DOUBLE, '                                        +  // 11. Precio total Venta sin iva
    'TAX INTEGER, '                                         +  // 12. IVA
    'STATE VARCHAR(10), '                                   +  // 13. Estado
    'STATE_NUMBER INTEGER, '                                +  // 14. Número del estado

    'DESCRIPTION BLOB, '                                    +  // 4.  Descripción

    'CREATEDBY VARCHAR(100)'                                +
    ');';

  tDataDocVenta_MySQL = 'CREATE TABLE SALEDOCUMENTDATA (' +
    'ID INTEGER NOT NULL, '                               +  // 0.  Número de la línea
    'SALEDOCUMENT_CODE VARCHAR(10) NOT NULL, '            +  // 1.  ID Documento de compra
    'ELEMENT_INDEX VARCHAR(10), '                         +  // 2.  Indice del elemento
    'ELEMENT_CODE VARCHAR(20), '                          +  // 3.  ID del elemento
    'ELEMENT_TYPE VARCHAR(2), '                           +  // 4.  Tipo de elemento
    'NODEINDEX INTEGER, '                                 +  // 5.  Nodo del elemento
    'ELEMENT_TITLE VARCHAR(80), '                         +  // 6.  Título del elemento
    'ELEMENT_DESCRIPTION BLOB, '                          +  // 7.  Descripción del elemento
    'ELEMENT_UNIT_AMOUNT FLOAT, '                         +  // 8.  Cantidad unitaria del elemento
    'ELEMENT_TOTAL_AMOUNT FLOAT, '                        +  // 9.  Cantidad total
    'ELEMENT_UNIT VARCHAR(2), '                           +  // 10. ID de la unidad
    'ELEMENT_PRICE FLOAT, '                               +  // 11. Precio del elemento
    'PARENT INTEGER, '                                    +  // 12. Nº Línea del padre

    'BENEFIT FLOAT, '                                     +  // 14. Beneficio
    'DISCOUNT FLOAT, '                                    +  // 15. Descuento

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, '      +  // 16. Fecha de creación
    'CREATEDBY VARCHAR(100), ' +

    'PRIMARY KEY(ID, SALEDOCUMENT_CODE));';

  //---------------------- DOCUMENTOS DE COMPRA --------------------------------
  tDocCompra_MySQL = 'CREATE TABLE BUYDOCUMENT ('         +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '     +  // 0.  ID
    'TYPE VARCHAR(2)	NOT NULL, '                +  // 1.  Tipo de documento:
    'CODE VARCHAR(20) NOT NULL, '                +  // 2.  Código documento
    'SUPPLIER_CODE VARCHAR(10) NOT NULL, '                +  // 3.  Código proveedor
    'SUPPLIER_NAME VARCHAR(60) NOT NULL, '                +  // 4.  Nombre proveedor
    'PROJECT_CODE VARCHAR(10), '                         +  // 5.  ID del proyecto
    'PROJECT_NAME VARCHAR(100), '                         +  // 6.  Referecia del proveedor(en caso de albarán o factura)

    'REFERENCE VARCHAR(50), '                         +  // 6.  Referecia del proveedor(en caso de albarán o factura)

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, '         +  // 7.  Fecha creación
    'VALIDTO DATETIME DEFAULT CURRENT_TIMESTAMP, '         +  // 8.  Fecha de entrega

    'PRICE DOUBLE		, '                          +  // 9.  Precio total Compra
    //'dcPVP		DOUBLE		, '                          +  // 10. Precio total Compra sin iva
    'TAX INTEGER,		'                            +  // 11. IVA
    'CREATEDBY VARCHAR(100) ' +
    ');';

  tDataDocCompra_MySQL = 'CREATE TABLE BUYDOCUMENTDATA ('    +
    'ID INTEGER 	NOT NULL, '                           +  // 0.  ID linea
    'BUYDOCUMENT_CODE	VARCHAR(10)	NOT NULL, '           +  // 1.  ID Documento de compra
    'ELEMENT_CODE VARCHAR(20), '                        +  // 2.  ID del elemento
    'ELEMENT_SUPPLIER_CODE VARCHAR(20), '               +  // 3.  ID del elemento que tiene el proveedor
    'ELEMENT_NAME VARCHAR(80), '                        +  // 4.  Descripción del elemento
    'ELEMENT_MANUFACTURER VARCHAR(40), '                +  // 5.  Fabricante
    'ELEMENT_AMOUNT FLOAT, '                            +  // 6.  Cantidad
    'ELEMENT_UNIT VARCHAR(2), '                         +  // 7.  ID de la unidad
    'ELEMENT_REAL_PRICE FLOAT, '                        +  // 8.  PVP de compra del elemento
    'ELEMENT_DISCOUNT FLOAT, '                          +  // 9.  Descuento
    'ELEMENT_PURCHASE_PRICE FLOAT, '                    +  // 10. Precio de Compra del elemento
    'DELIVERY_DATE DATETIME, '                              +  // 11. Fecha de Entrega del elemento

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, '         +  // 14. Fecha de creación
    'CREATEDBY VARCHAR(100), '                          +

    'PRIMARY KEY(ID, BUYDOCUMENT_CODE));';
  //----------------------- PROYECTO -----------------------------------------
  tProyecto_MySQL = 'CREATE TABLE PROJECT ('               +
    'ID	INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 0.  ID
    'CODE	VARCHAR(20) NOT NULL, '                    +  // 1.  ID
    'TITLE	VARCHAR(100) NOT NULL, '                 +  // 2.  Título
    'CUSTOMER_CODE	VARCHAR(10) NOT NULL, '          +  // 3.  ID Cliente
    'CUSTOMER_NAME	VARCHAR(60) NOT NULL, '          +  // 4.  Nombre del cliente
    'START_DATE	DATETIME DEFAULT CURRENT_TIMESTAMP, '         +  // 5.  Fecha de Inicio
    'DURATION	DATETIME, '                                +  // 6.  Fecha de Inicio
    'STATE	VARCHAR(10), '                           +  // 7.  Estado

    // Dirección de la obra
    'CONTACT	VARCHAR(60), '                         +  // 8.  Contacto
    'ADDRESS1	VARCHAR(40), '                         +  // 9.  Dir L1
    'ADDRESS2	VARCHAR(40), '                         +  // 10.  Dir L2
    'POSTCODE	VARCHAR(9), '                          +  // 11. CP
    'CITY	VARCHAR(80), '                             +  // 12. Ciudad
    'PHONE	VARCHAR(20), '                           +  // 13. Telefono
    'MOBILE	VARCHAR(20), '                           +  // 14. Movil
    'EMAIL	VARCHAR(60), '                           +  // 15. e-mail

    'pyGantt BLOB,'                                  +  // 16. Imagen

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  tProjectControl_MySQL = 'CREATE TABLE PROJECTCONTROL ('  +
    'ID	INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01.  ID
    'pcPYCODE	VARCHAR(20) NOT NULL, '                +  // 02.  ID
    'pcELID	VARCHAR(20) NOT NULL, '                  +  // 03.  ID
    'pcELTITLE VARCHAR(100) NOT NULL, '              +  // 04.  ID Cliente
    'pcELTOTAL	FLOAT, '                             +  // 05.  Nombre del cliente
    'pcELINSTALLED FLOAT, '                          +  // 06.  Fecha de Inicio
    'pcELREST	FLOAT, '                               +  // 07.  Fecha de Inicio
    'pcELUNIT	VARCHAR(2), '                          +  // 08.  Estado
    'pcELDATE	DATETIME DEFAULT CURRENT_TIMESTAMP, '           +  // 09.  Estado
    'pcELTYPE VARCHAR(3), '                          +
    'pcELNODEINDEX INTEGER, '                        +
    'pcTASK VARCHAR(50), '                           +

    'pcCREATEDBY VARCHAR(100), '                       +
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP'      +
    ');';

  //----------------------- TRABAJADOR ---------------------------------------
  tTrabajador_MySQL = 'CREATE TABLE EMPLOYEE ('            +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01. ID
    'SURNAME VARCHAR(60) NOT NULL, '                 +  // 02. Apellidos
    'NAME VARCHAR(60) NOT NULL, '                    +  // 03. Nombre
    'STATE	BOOLEAN	DEFAULT FALSE, '                 +  // 04. Activo o inactivo
    'CATEGORY VARCHAR(30), '                         +  // 05. Categoría
    'PRICEPERHOUR	FLOAT, '                           +  // 06. Precio Hora
    'NOTES BLOB,'                                    +  // 07. Notas
    'PICTURE BLOB,'                                   +

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //----------------------- CONTACTOS -----------------------------------------
  tContact_MySQL = 'CREATE TABLE CONTACT ('                +
    'coID	INTEGER PRIMARY KEY AUTO_INCREMENT, '       +  // 01. ID
    'coCode	VARCHAR(20) NOT NULL, '                  +  // 02. Code
    'coNombre	VARCHAR(60) NOT NULL, '                +  // 03. Nombre
    'coApellido	VARCHAR(60) NOT NULL, '              +  // 04. Apellidos
    'coForma	VARCHAR(10), '                         +  // 05. Forma

    'coPuesto	VARCHAR(20), '                         +  // 06. Puesto
    'coclCode	VARCHAR(10), '                         +  // 07. Código Empresa
    'coclNom VARCHAR(60), '                          +  // 08. Nombre Empresa
    'coTel	VARCHAR(20), '                           +  // 09. Teléfono fijo
    'coMovil	VARCHAR(20), '                         +  // 10. Teléfono móvil
    'coFax	VARCHAR(20), '                           +  // 11. Fax
    'coEMail	VARCHAR(60),'                          +  // 12. e-mail
    'coImage BLOB,'                                  +  // 13. Imagen

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, ' +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //----------------------- LAZREPORT -----------------------------------------
  tLazReport_MySQL = 'CREATE TABLE LazReportTemplates ('   +
    'ID	INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01. ID
    'TEMPLATE BLOB,'                                 +  // 02. Imagen
    'NAME	VARCHAR(60), '                             +  // 03. Nombre
    'IMAGE BLOB,'                                    +  // 04. Imagen

    'TYPE VARCHAR(10),'                              +  // 04. Imagen

    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP, '      +   // 25. Fecha de creación
    'CREATEDBY VARCHAR(100)'+
    ');';

  //----------------------- CALENDAR ------------------------------------------
  tCalendar_MySQL = 'CREATE TABLE DAYSOFFCALENDAR ('       +
    'ID	INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01. ID
    'NAME VARCHAR(60) NOT NULL,'                     +  // 02. Nombre del Calendario
    'DAY DATETIME, '                                     +  // 03. Fecha
    'DAYOFF BOOLEAN	DEFAULT FALSE,'                  +  // 04. Dia festivo
    'WORKINGHOURS DOUBLE DEFAULT 24'                 +  // 05. Horas laborables
    ');';

  //----------------------- GANTT TASK ----------------------------------------
  tTask_MySQL = 'CREATE TABLE TASK ('                      +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01. ID
    'TASK_ID VARCHAR(50), '                          +  // 01. Task ID
    'PARENT VARCHAR(50), '                           +
    'SUMMARY VARCHAR(100) NOT NULL, '                +  // 01. Is Complete
    'PROJECTID VARCHAR(20), '                        +
    'PROJECT VARCHAR(100), '                         +
    'HASCHILDS BOOLEAN NOT NULL, '                   +  // 01. has children
    'PERCENT DATETIME, '                             +
    'STARTDATE DATETIME, '                           +
    'FINISHDATE DATETIME, '                          +
    'EARLIEST DATETIME, '                            +
    'DURATION DATETIME, '                            +
    'NETDURATION DATETIME, '                         +
    'NETTIME DATETIME, '                             +
    'WAITTIME DATETIME, '                            +
    'STARTED BOOLEAN, '                              +  // 01. Is Complete
    'DEPDONE BOOLEAN, '                              +  // 01. Is Complete
    'VISIBLE BOOLEAN, '                              +  // 01. Is Complete
    'OPENED BOOLEAN, '                               +  // 01. Is Complete
    'DONTCHANGE BOOLEAN, '                           +  // 01. Is Complete
    'RESOURCE VARCHAR(260), '                        +
    'RESOURCEPERDAY FLOAT, '                         +
    'COLOR BIGINT, '                                 +
    'FIXED BOOLEAN, '                                +  // 01. Is Complete
    'COMPLETE BOOLEAN NOT NULL, '                    +  // 01. Is Complete
    'STARTEDAT DATETIME, '                           +
    'COMPLETEDAT DATETIME, '                         +

    'CREATEDBY VARCHAR(100), '                       +
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP'        +
    ');';

  tTaskConnections_MySQL = 'CREATE TABLE TASKCONNECTIONS ('+
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01. ID
    'PROJECTID VARCHAR(20), '                        +
    'TASK_ID VARCHAR(50), '                          +  // 01. Task ID
    'TASK_ID_CONNECTION VARCHAR(50), '               +

    'CREATEDBY VARCHAR(100), '                       +
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP'        +
    ');';

  tTaskResources_MySQL = 'CREATE TABLE TASKRESOURCES ('    +
    'ID INTEGER PRIMARY KEY AUTO_INCREMENT, '         +  // 01. ID
    'PROJECTID VARCHAR(20), '                        +
    'TASK_ID VARCHAR(50), '                          +  // 01. Task ID
    'NAME VARCHAR(80), '                             +
    'TYPE INTEGER, '                                 +
    'DURATION DATETIME, '                            +
    'QUANTITY FLOAT, '                               +
    'COST FLOAT, '                                     +

    'CREATEDBY VARCHAR(100), '                       +
    'CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP'        +
    ');';

  const List_MySQL: array[1..25] of string = (tDBUsers_MySQL, tDBInfo_MySQL,
    tEmpresaInfo_MySQL, tCliente_MySQL, tForma_MySQL, tFamCli_MySQL,
    tFamProv_MySQL, tElemento_MySQL, tElemComp_MySQL, tProveedor_MySQL,
    tFamEle_MySQL, tUnidad_MySQL, tDocVenta_MySQL, tDataDocVenta_MySQL,
    tDocCompra_MySQL, tDataDocCompra_MySQL, tProyecto_MySQL, tProjectControl_MySQL,
    tTrabajador_MySQL, tContact_MySQL, tLazReport_MySQL, tCalendar_MySQL,
    tTask_MySQL, tTaskConnections_MySQL, tTaskResources_MySQL);

implementation

end.

