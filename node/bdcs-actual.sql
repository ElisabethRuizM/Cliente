drop database if exists bdcs;
create  database bdcs;
use bdcs;
-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-08-2017 a las 01:02:27
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdcs`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen`
--

CREATE TABLE `almacen` (
  `idAlmacen` int(11) NOT NULL,
  `IdEmpleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `almacen`
--

INSERT INTO `almacen` (`idAlmacen`, `IdEmpleado`) VALUES
(1, 3),
(2, 4),
(3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenequipo`
--

CREATE TABLE `almacenequipo` (
  `IdAlmacen` int(11) NOT NULL,
  `IdEquipo` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `almacenequipo`
--

INSERT INTO `almacenequipo` (`IdAlmacen`, `IdEquipo`, `Cantidad`) VALUES
(1, 2,3),
(1, 3,6),
(2, 3,2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `direccion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Latitud` decimal(9,5) NOT NULL,
  `Longitud` decimal(9,5) NOT NULL,
  `idPersona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
 insert into `cliente`(`idCliente`,`direccion`,`Latitud`,`Longitud`,`idPersona`) values
  (1,'Calle Los Arces 206',-8.1284368,-79.0307369,5),
  (2,'Avenida América Norte',-8.1082763,-79.0207743,6);
--
-- Volcado de datos para la tabla `cliente`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--
-- estado O: Ocupado, D: Desocupado
--
CREATE TABLE `empleado` (
  `idEmpleado` int(11) NOT NULL,
  `cargo` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `estado` char(1) CHARACTER SET utf8 DEFAULT NULL,
  `fechaIngreso` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `cargo`, `estado`, `fechaIngreso`, `idPersona`) VALUES
(1, 'Jefe de Logistica', 'O', '2017-06-28 01:02:23', 1),
(2, 'Supervisor', 'O', '2017-06-28 01:02:23', 2),
(3, 'Tecnico', 'D','2017-06-28 01:02:23', 3),
(4, 'Tecnico', 'D', '2017-06-28 01:02:23', 4),
(5, 'Tecnico', 'D', '2017-06-28 01:02:23', 5);


--
-- Disparadores `empleado`
--
DELIMITER $$
CREATE TRIGGER `GenerarAlmacenUsuario` AFTER INSERT ON `empleado` FOR EACH ROW if new.cargo='Tecnico'
then
    insert into almacen(idEmpleado) values(new.idEmpleado);
    INSERT INTO usuario(IdEmpleado,Usuario, Password,tipo) VALUES (NEW.IdEmpleado, concat('usuario',New.IdEmpleado,'000'), concat('pass123',NEW.IdEmpleado,'abc'),3);
end if
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--
-- estado Habilitado, Deshabilitado
--
CREATE TABLE `equipo` (
  `id` int(11) NOT NULL,
  `codigoSap` char(11) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `unidadMedida` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`id`, `codigoSap`, `descripcion`, `stock`, `unidadMedida`, `estado`, `fechaRegistro`) VALUES
(2, '10097648425', 'Telefono', 5, 'unidad', 'Habilitado', '2017-06-27'),
(3, '10975286743', 'Modem', 2, 'unidad', 'Habilitado', '2017-06-26'),
(4, '10406110271', 'ACCESS POINT DUAL BAND 2.4-5Ghz', 2, 'unidades', 'Habilitado', '2017-06-27'),
(5, '10402150000', 'ALAMBRE PUENTE TP.2-0.5 BLANCO-ROJO', 300, 'metros', 'Habilitado', '2017-06-27'),
(6, '00007931851', 'AMPLIFICADOR BAJO RUIDO OPTIMIZADO LNB', 20, 'unidades', 'Habilitado', '2017-06-27'),
(7, '00004880430', 'ANTENA PARABOLICA DTH BDA KU-60 CM.DM', 44, 'unidades','Habilitado', '2017-06-27'),
(8, '10402570023', 'BLOCK DE CONEXION PARA PROTECCION', 100, 'unidades','Habilitado', '2017-06-27'),
(9, '10402580026', 'BLOCK TERMIN.D/COMUNICACS.2 MUELLS.C/GEL', 155, 'unidades','Habilitado', '2017-06-27'),
(10, '10402510011', 'CABLE ACOMETIDA AUTOSOPORTADO 1 PAR', 2000, 'metros','Habilitado', '2017-06-27'),
(11, '00007520097', 'CABLE COAXIAL PE-CU RG-11 AL 90%', 300, 'metros','Habilitado', '2017-06-27'),
(12, '00007520080', 'CABLE COAXIAL RG-6 TRISHIELD C/MENSAJERO', 500, 'metros','Habilitado', '2017-06-27'),
(13, '00007520111', 'CABLE COAXIAL RG-6 TRISHIELD S/MENSAJERO', 1000, 'metros','Habilitado', '2017-06-27'),
(14, '10402510012', 'CABLE INTERIOR 2 CONDUCTORES', 900, 'metros','Habilitado', '2017-06-27'),
(15, '00001520020', 'CABLE UTP CAT.5E 24AWG 4P 155MHZ.', 100, 'metros', 'Habilitado', '2017-06-27'),
(16, '10402150006', 'CABLE UTP CAT.5e 24AWG 4P 200MHZ', 40, 'metros','Habilitado', '2017-06-27'),
(17, '10407930046', 'CABLEMODEM DOCSIS 3', 50, 'unidades','Habilitado', '2017-06-27'),
(18, '10402610264', 'CINTILLO NYLON NUMERADO AMARILLO', 60, 'unidades','Habilitado', '2017-06-27'),
(19, '00007931021', 'CONECTOR AXIAL RG-6', 3000, 'unidades','Habilitado', '2017-06-27'),
(20, '10407110539', 'CONTROL REMOTO UNIVERSARL (MULTIMARCA)', 500, 'unidades','Habilitado', '2017-06-27'),
(21, '10407110512', 'DECODIFICADOR CATV- HD BASICO', 50, 'unidades','Habilitado', '2017-06-27'),
(22, '00007870141', 'TARJETA INTELIGENTE DTH', 100, 'unidades','Habilitado', '2017-06-27'),
(23, '10401500172', 'TELEFONO ESTANDAR', 80, 'unidades','Habilitado', '2017-06-27'),
(24, '10406100177', 'MODEM RESIDENCIAL VDSL C VOIP', 60, 'unidades', 'Habilitado', '2017-06-27'),
(25, '10402510041', 'GRAPA CABLE COAXIAL INTERIOR', 10, 'cajas', 'Habilitado', '2017-06-27'),
(26, '10402560119', 'TEMPLADOR TP."P" PARA ALAMBRE DE BAJADA', 500, 'unidades','Habilitado', '2017-06-27'),
(27, '10402560112', 'GRAPA DOS CLAVOS A2 21 mm MARFIL', 1000, 'unidades','Habilitado', '2017-06-27'),
(28, '85991200691', 'Reloj', 1, 'Unidades', 'Habilitado', '0000-00-00 00:00:00'),
(29, '00000000235', 'Reloj con mouse', 1, 'Unidad', 'Habilitado', '2017-07-01 23:25:18'),
(30, '00000001234', 'Mouse', 25, 'Unidad', 'Habilitado', '2017-07-01 23:31:45'),
(31, '00005123465', 'Cable', 2, 'Unidad', 'Habilitado', '2017-07-01 23:34:26'),
(32, '00000000666', 'Tablet', 2, 'Unidad', 'Habilitado', '2017-07-01 23:34:27'),
(33, '00000457878', 'Usb', 1, 'Unidad', 'Habilitado', '2017-07-01 23:39:02'),
(34, '01053300413', 'Jordan', 2, 'U', 'Habilitado', '2017-07-02 00:32:50'),
(35, '85991200691', 'Caja reloj', 1, 'Unidad', 'Habilitado', '2017-07-04 22:07:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lote`
--

CREATE TABLE `lote` (
  `idLote` int(11) NOT NULL,
  `codigo` char(10) CHARACTER SET utf8 DEFAULT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `lote`
--

INSERT INTO `lote` (`idLote`, `codigo`, `fechaRegistro`) VALUES
(1, 'AGRDY23JUA', '2017-06-27 05:00:00'),
(2, '89123', '0000-00-00 00:00:00'),
(3, '190012', '2017-06-28 05:33:33'),
(4, '563412', '2017-06-28 05:59:08'),
(5, '3121', '2017-06-28 06:02:23'),
(6, '3215846', '2017-06-28 06:03:09'),
(7, '563249', '2017-06-30 02:54:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loteequipo`
--

CREATE TABLE `loteequipo` (
  `IdLote` int(11) NOT NULL,
  `IdEquipo` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `loteequipo`
--

INSERT INTO `loteequipo` (`IdLote`, `IdEquipo`, `Cantidad`) VALUES
(1, 2, 1),
(1, 3, 1);

--
-- Disparadores `loteequipo`
--
DELIMITER $$
CREATE TRIGGER `GenerarMoviemientoE` AFTER INSERT ON  `loteequipo` 
FOR EACH
ROW INSERT INTO MovimientoAlmacen( Tipomovimiento, IdEquipo, Cantidad  ) 
VALUES ( 1, NEW.IdEquipo,  New.Cantidad );
$$
DELIMITER ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientoalmacen` TipoMovimiento 1 ingreso lotes principal, 0 intercambio principal almacen, 2 salida almacen
--

CREATE TABLE `movimientoalmacen` (
  `IdMovimiento` int(11) NOT NULL,
  `TipoMovimiento` int(11) NOT NULL,
  `IdEquipo` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `IdAlmacen` int(11) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Disparadores `movimientoalmacen`
--
DELIMITER $$
CREATE  TRIGGER `ActualizarStock` AFTER INSERT ON  `movimientoalmacen` 
FOR EACH
ROW if New.tipomovimiento=1 then
update Equipo set stock=stock+New.cantidad where id=New.idEquipo;
elseif New.tipomovimiento=0 then
update Equipo set stock=stock-New.Cantidad where id=New.idEquipo;
if(select count(*) from almacenequipo where idEquipo=New.idEquipo and idAlmacen=New.idAlmacen) =0 then
insert into almacenequipo(IdAlmacen, IdEquipo, Cantidad) values (New.IdAlmacen, New.IdEquipo, New.Cantidad);
else
update almacenequipo set cantidad=cantidad+New.cantidad where idEquipo=New.idEquipo and idAlmacen=New.idAlmacen;
end if;
else update almacenequipo set cantidad=cantidad-New.cantidad where idEquipo=New.idEquipo and idAlmacen=New.idAlmacen;
end if
$$
DELIMITER ;






-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
  `nombres` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `dni` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(9) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `nombres`, `apellidos`, `dni`, `email`, `telefono`) VALUES
(1, 'Jordan', 'Rojas Alarcon', '42182930', 'jordanrojas@gmail.com', '948920375'),
(2, 'Cristhian', 'Delgado Chau', '76281976', 'chiquidc@hotmail.com', '938748274'),
(3, 'Pamela', 'Lizarraga Alvarez', '23456789', 'pamelaliza@gmail.com', '938517284'),
(4, 'Jordyn', 'Toribio', '47281746', 'toribio12@gmail.com', '927848264'),
(5, 'Elisabeth', 'Ruiz Mendoza', '48205352', 'elisabethrm@gmail.com', '948960285'),
(6, 'Juan', 'Sanchez', '7030852', 'asd@hotmail.com', '140746988'),
(7, 'Pedro', 'Alvarez', '40508060', 'monica@hotmail.com', '963258740');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio` idTipo  1 Cable, 2 Telefono, 3 Internet  estado  Registrado: 1, Asignado: 2, Atendido sin verificar: 3, Atendido con éxito:4, Atendido sin éxito: 5
--
CREATE TABLE `servicio` (
  `idServicio` int(11) NOT NULL,
  `descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `idTipo` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `idCliente` int(11) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  `fechaAtencion` date DEFAULT NULL,
  `fechaVerificacion` date DEFAULT NULL,
  `fechaSolicitud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `servicio`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicioequipo`
--

CREATE TABLE `servicioequipo` (
  `IdServicio` int(11) NOT NULL,
  `IdEquipo` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `servicioequipo`
--


--
-- Disparadores `almacenequipo`
--
DELIMITER $$
CREATE  TRIGGER `GenerarMoviemientoS` AFTER INSERT ON  `servicioequipo` 
FOR EACH
ROW BEGIN 
DECLARE empleado INT;
declare almacen int;
SELECT idempleado
INTO empleado
FROM servicio
WHERE idservicio = NEW.IdServicio;
select idalmacen into almacen from almacen where idempleado=empleado;
INSERT INTO MovimientoAlmacen( Tipomovimiento, IdEquipo, Cantidad, IdAlmacen  ) 
VALUES ( 2, NEW.IdEquipo, New.Cantidad, almacen );
end
$$
DELIMITER ;

-- --------------------------------------------------------

--

-- Estructura de tabla para la tabla `tiposervicio`
--

CREATE TABLE `tiposervicio` (
  `IdTipoServicio` int(11) NOT NULL,
  `descripcion` varchar(20) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tiposervicio`
--

INSERT INTO `tiposervicio` (`IdTipoServicio`, `descripcion`) VALUES
(1, 'Cable'),
(2, 'Telefono'),
(3, 'Internet');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `IdTipoUsuario` int(11) NOT NULL,
  `Descripcion` varchar(30) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`IdTipoUsuario`, `Descripcion`) VALUES
(1, 'Jefe de Logistica'),
(2, 'Supervisor'),
(3, 'Tecnico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `IdUbicacion` int(11) NOT NULL,
  `Latitud` decimal(9,5) NOT NULL,
  `Longitud` decimal(9,5) NOT NULL,
  `FechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IdEmpleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`IdUbicacion`, `Latitud`, `Longitud`, `FechaRegistro`, `IdEmpleado`) VALUES
(1, '-8.10622', '-79.06511', '2017-06-27', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario` tipo(1, 'Jefe de Logistica'),(2, 'Supervisor'),(3, 'Tecnico');
--
CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  `usuario` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` int(11) NOT NULL,
  `token` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idEmpleado`, `usuario`, `password`, `tipo`, `token`) VALUES
(1, 1, 'jrojasa', 'jordan', 1, 'dxsL70FR8O0:APA91bGOHHRX5JRFGIp6CQka9lUHdcy04C0xWH8-LKOtKyB4JV0A7Xw75fSKCVpFkJbRCF9NQa6Uzk6eiwm7YVfektWfJM0XkgYpsBLcZezocvlh6Gpyg4As9cZ6SGO_aKp5BR86r5Fz'),
(2, 2, 'cdelgadoc', 'cristhian', 2, 'dggK-5c8Eic:APA91bGu7wT1qAEuUJ39uhqb6OrhpGJ9IffsvgtDyF9jBcHUZbUff0R2rgvRqqgiGGbXadMV339raoCzC1zyxdCWd2BgrEvY8q6VH2mMSzCh1ML28sQ3uCN9Ql6eiMjiX2No1RuHlVot'),
(3, 3, 'plizarragaa', 'pamela', 3, NULL),
(4, 4, 'jtoribioe', 'jordyn', 3, NULL),
(5, 5, 'elisabethrm', 'elisabeth1234', 3, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lote`
--

CREATE TABLE `abastecimiento` (
  `idAbastecimiento` int(11) NOT NULL,
  `idAlmacen` int(11) NOT NULL,
  `codigo` char(10) CHARACTER SET utf8 DEFAULT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loteequipo`
--

CREATE TABLE `abastecimientoequipo` (
  `idAbastecimiento` int(11) NOT NULL,
  `IdEquipo` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


--
-- Disparadores `loteequipo`
--


DELIMITER $$
CREATE TRIGGER `GenerarMovimientoI` AFTER INSERT ON  `abastecimientoequipo` 
FOR EACH
ROW
begin
declare almacen int;
select idalmacen into almacen from abastecimiento where idabastecimiento=NEW.Idabastecimiento; 
INSERT INTO MovimientoAlmacen( Tipomovimiento, IdEquipo, Cantidad, IdAlmacen  ) 
VALUES ( 0, NEW.IdEquipo,  New.Cantidad, almacen );
end
$$
DELIMITER ;
--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD PRIMARY KEY (`idAlmacen`),
  ADD KEY `FK_almacen_empleado` (`IdEmpleado`);

--
-- Indices de la tabla `almacenequipo`
--
ALTER TABLE `almacenequipo`
  ADD PRIMARY KEY (`idAlmacen`,`IdEquipo`),
  ADD KEY `FK_AlmacenEquipo_equipo` (`IdEquipo`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`),
  ADD KEY `FK_cliente_persona` (`idPersona`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `persona_empleado` (`idPersona`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lote`
--
ALTER TABLE `lote`
  ADD PRIMARY KEY (`idLote`);

--
-- Indices de la tabla `loteequipo`
--
ALTER TABLE `loteequipo`
  ADD PRIMARY KEY (`IdLote`,`IdEquipo`),
  ADD KEY `FK_LoteEquipo_equipo` (`IdEquipo`);


--
-- Indices de la tabla `lote`
--
ALTER TABLE `abastecimiento`
  ADD PRIMARY KEY (`idAbastecimiento`),
  ADD KEY `almacen_abastecimiento` (`idAlmacen`);

--
-- Indices de la tabla `loteequipo`
--
ALTER TABLE `abastecimientoequipo`
  ADD PRIMARY KEY (`idAbastecimiento`,`IdEquipo`),
  ADD KEY `FK_AbastecimientoEquipo_equipo` (`IdEquipo`);

--
-- Indices de la tabla `movimientoalmacen`
--
ALTER TABLE `movimientoalmacen`
  ADD PRIMARY KEY (`IdMovimiento`),
  ADD KEY `FK_MovimientoAlmacen_equipo` (`IdEquipo`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`idServicio`),
  ADD KEY `cliente_servicio` (`idCliente`),
  ADD KEY `FK_servicio_empleado` (`idEmpleado`),
  ADD KEY `FK_servicio_TipoServicio` (`idTipo`);

--
-- Indices de la tabla `servicioequipo`
--
ALTER TABLE `servicioequipo`
  ADD PRIMARY KEY (`IdServicio`,`IdEquipo`),
  ADD KEY `FK_ServicioEquipo_equipo` (`IdEquipo`);


--
-- Indices de la tabla `tiposervicio`
--
ALTER TABLE `tiposervicio`
  ADD PRIMARY KEY (`IdTipoServicio`);

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`IdTipoUsuario`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`IdUbicacion`),
  ADD KEY `FK_Ubicacion_empleado` (`IdEmpleado`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `empleado_usuario` (`idEmpleado`),
  ADD KEY `FK_usuario_TipoUsuario` (`tipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacen`
--
ALTER TABLE `almacen`
  MODIFY `idAlmacen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT de la tabla `lote`
--
ALTER TABLE `lote`
  MODIFY `idLote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `lote`
--
ALTER TABLE `abastecimiento`
  MODIFY `idAbastecimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT de la tabla `movimientoalmacen`
--
ALTER TABLE `movimientoalmacen`
  MODIFY `IdMovimiento` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `idServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
--
-- AUTO_INCREMENT de la tabla `tiposervicio`
--
ALTER TABLE `tiposervicio`
  MODIFY `IdTipoServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `IdTipoUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `IdUbicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD CONSTRAINT `FK_almacen_empleado` FOREIGN KEY (`IdEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `almacenequipo`
--
ALTER TABLE `almacenequipo`
  ADD CONSTRAINT `FK_AlmacenEquipo_almacen` FOREIGN KEY (`idAlmacen`) REFERENCES `almacen` (`idAlmacen`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_AlmacenEquipo_equipo` FOREIGN KEY (`IdEquipo`) REFERENCES `equipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_cliente_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `persona_empleado` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER table `abastecimiento`
  add CONSTRAINT `almacen_abastecimiento` FOREIGN KEY (`IdAlmacen`) REFERENCES `almacen` (`idAlmacen`) on DELETE CASCADE on UPDATE CASCADE;
--
-- Filtros para la tabla `loteequipo`
--
ALTER TABLE `loteequipo`
  ADD CONSTRAINT `FK_LoteEquipo_equipo` FOREIGN KEY (`IdEquipo`) REFERENCES `equipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_LoteEquipo_lote` FOREIGN KEY (`IdLote`) REFERENCES `lote` (`idLote`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `loteequipo`
--
ALTER TABLE `abastecimientoequipo`
  ADD CONSTRAINT `FK_AbastecimientoEquipo_equipo` FOREIGN KEY (`IdEquipo`) REFERENCES `equipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_AbastecimientoEquipo_abastecimiento` FOREIGN KEY (`idAbastecimiento`) REFERENCES `abastecimiento` (`idAbastecimiento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimientoalmacen`
--
ALTER TABLE `movimientoalmacen`
  ADD CONSTRAINT `FK_MovimientoAlmacen_equipo` FOREIGN KEY (`IdEquipo`) REFERENCES `equipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `FK_servicio_TipoServicio` FOREIGN KEY (`idTipo`) REFERENCES `tiposervicio` (`IdTipoServicio`),
  ADD CONSTRAINT `FK_servicio_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cliente_servicio` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `servicioequipo`
--
ALTER TABLE `servicioequipo`
  ADD CONSTRAINT `FK_ServicioEquipo_equipo` FOREIGN KEY (`IdEquipo`) REFERENCES `equipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ServicioEquipo_servicio` FOREIGN KEY (`IdServicio`) REFERENCES `servicio` (`idServicio`) ON DELETE CASCADE ON UPDATE CASCADE;
 
--
-- Filtros para la tabla `solicitudequipo`
--
-- Filtros para la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD CONSTRAINT `FK_Ubicacion_empleado` FOREIGN KEY (`IdEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `FK_usuario_TipoUsuario` FOREIGN KEY (`tipo`) REFERENCES `tipousuario` (`IdTipoUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `empleado_usuario` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
