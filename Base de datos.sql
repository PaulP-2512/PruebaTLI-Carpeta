USE [master]
GO
/****** Object:  Database [PruebaTecnicaTLI]    Script Date: 16/10/2024 07:39:30 p. m. ******/
CREATE DATABASE [PruebaTecnicaTLI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PruebaTecnicaTLI', FILENAME = N'C:\SQLData\PruebaTecnicaTLI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PruebaTecnicaTLI_log', FILENAME = N'C:\SQLData\PruebaTecnicaTLI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PruebaTecnicaTLI] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PruebaTecnicaTLI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ARITHABORT OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET  MULTI_USER 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PruebaTecnicaTLI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PruebaTecnicaTLI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PruebaTecnicaTLI] SET QUERY_STORE = ON
GO
ALTER DATABASE [PruebaTecnicaTLI] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PruebaTecnicaTLI]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](255) NOT NULL,
	[Telefono] [nvarchar](15) NULL,
	[Correo] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleFactura](
	[IdDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdFactura] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncabezadoFactura]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncabezadoFactura](
	[IdFactura] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Stock] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([IdFactura])
REFERENCES [dbo].[EncabezadoFactura] ([IdFactura])
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[EncabezadoFactura]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCliente]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarCliente]
	@Id INT,
	@Nombre NVARCHAR(100),
	@Direccion NVARCHAR(255),
	@Telefono NVARCHAR(15),
	@Correo NVARCHAR(100)
AS
BEGIN
	UPDATE Clientes
	SET Nombre = @Nombre, Direccion = @Direccion, Telefono = @Telefono, Correo = @Correo
	WHERE IdCliente = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarDetalle]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarDetalle]
	@Id INT,
	@IdFactura INT,
	@IdProducto INT,
	@Cantidad INT,
	@PrecioUnitario DECIMAL(10, 2)
AS
BEGIN
	UPDATE DetalleFactura
	SET IdFactura = @IdFactura, IdProducto = @IdProducto, Cantidad = @Cantidad, PrecioUnitario = @PrecioUnitario
	WHERE IdDetalle = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEncabezado]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarEncabezado]
	@Id INT,
	@IdCliente INT,
	@Fecha DATE,
	@Total DECIMAL(10, 2)
AS
BEGIN
	UPDATE EncabezadoFactura
	SET IdCliente = @IdCliente, Fecha = @Fecha, Total = @Total
	WHERE IdFactura = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarProducto]
	@Id INT,
	@Nombre NVARCHAR(100),
	@Precio DECIMAL(10, 2),
	@Stock INT
AS
BEGIN
	UPDATE Productos
	SET Nombre = @Nombre, Precio = @Precio, Stock = @Stock
	WHERE IdProducto = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarCliente]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarCliente]
	@Id INT
AS
BEGIN
	DELETE FROM Clientes
	WHERE IdCliente = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarProducto]
	@Id INT
AS
BEGIN
	DELETE FROM Productos
	WHERE IdProducto = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[IngresarCliente]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngresarCliente]
    @Nombre NVARCHAR(100),
    @Direccion NVARCHAR(255),
    @Telefono NVARCHAR(15),
    @Correo NVARCHAR(100)  -- Campo Email agregado
AS
BEGIN
    INSERT INTO Clientes (Nombre, Direccion, Telefono, Correo)
    VALUES (@Nombre, @Direccion, @Telefono, @Correo);
END;
GO
/****** Object:  StoredProcedure [dbo].[IngresarDetalleFactura]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngresarDetalleFactura]
    @IdFactura INT,
    @IdProducto INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO DetalleFactura (IdFactura, IdProducto, Cantidad, PrecioUnitario)
    VALUES (@IdFactura, @IdProducto, @Cantidad, @PrecioUnitario);
END;
GO
/****** Object:  StoredProcedure [dbo].[IngresarEncabezadoFactura]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngresarEncabezadoFactura]
    @IdCliente INT,
    @Fecha DATE,
    @Total DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO EncabezadoFactura (IdCliente, Fecha, Total)
    VALUES (@IdCliente, @Fecha, @Total);
END;
GO
/****** Object:  StoredProcedure [dbo].[IngresarProducto]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngresarProducto]
    @Nombre NVARCHAR(100),
    @Precio DECIMAL(10, 2),
    @Stock INT
AS
BEGIN
    INSERT INTO Productos (Nombre, Precio, Stock)
    VALUES (@Nombre, @Precio, @Stock);
END;
GO
/****** Object:  StoredProcedure [dbo].[ListarClientes]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarClientes]
AS
BEGIN
	SELECT *
	FROM Clientes
END
GO
/****** Object:  StoredProcedure [dbo].[ListarClientesPorId]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarClientesPorId]
	@Id INT
AS
BEGIN
	SELECT *
	FROM Clientes
	WHERE IdCliente=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[ListarDetalleFactura]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarDetalleFactura]
AS
BEGIN
	SELECT *
	FROM DetalleFactura
END
GO
/****** Object:  StoredProcedure [dbo].[ListarDetallesPorId]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarDetallesPorId]
	@Id INT
AS
BEGIN
	SELECT *
	FROM DetalleFactura
	WHERE IdFactura=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[ListarEncabezadoFactura]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarEncabezadoFactura]
AS
BEGIN
	SELECT *
	FROM EncabezadoFactura
END
GO
/****** Object:  StoredProcedure [dbo].[ListarEncabezadosPorId]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarEncabezadosPorId]
	@Id INT
AS
BEGIN
	SELECT *
	FROM EncabezadoFactura
	WHERE IdFactura=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[ListarProductos]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarProductos]
AS
BEGIN
	SELECT *
	FROM Productos
END
GO
/****** Object:  StoredProcedure [dbo].[ListarProductosPorId]    Script Date: 16/10/2024 07:39:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarProductosPorId]
	@Id INT
AS
BEGIN
	SELECT *
	FROM Productos
	WHERE IdProducto=@Id
END
GO
USE [master]
GO
ALTER DATABASE [PruebaTecnicaTLI] SET  READ_WRITE 
GO
