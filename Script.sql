USE [master]
GO
/****** Object:  Database [Olist]    Script Date: 27/05/2023 22:37:01 ******/
CREATE DATABASE [Olist]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Olist', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Olist.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Olist_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Olist_log.ldf' , SIZE = 532480KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Olist] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Olist].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Olist] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Olist] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Olist] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Olist] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Olist] SET ARITHABORT OFF 
GO
ALTER DATABASE [Olist] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Olist] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Olist] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Olist] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Olist] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Olist] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Olist] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Olist] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Olist] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Olist] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Olist] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Olist] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Olist] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Olist] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Olist] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Olist] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Olist] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Olist] SET RECOVERY FULL 
GO
ALTER DATABASE [Olist] SET  MULTI_USER 
GO
ALTER DATABASE [Olist] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Olist] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Olist] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Olist] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Olist] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Olist', N'ON'
GO
ALTER DATABASE [Olist] SET QUERY_STORE = OFF
GO
USE [Olist]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Olist]
GO
/****** Object:  Table [dbo].[cargar_hechos]    Script Date: 27/05/2023 22:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargar_hechos](
	[order_id] [varchar](200) NOT NULL,
	[customer_id] [varchar](200) NULL,
	[product_id] [varchar](200) NULL,
	[price] [money] NULL,
	[freight_value] [money] NULL,
	[status_id] [varchar](200) NULL,
	[date_id_purchase] [datetime] NULL,
	[date_id_delivered_carrier] [datetime] NULL,
	[date_id_delivered_customer] [datetime] NULL,
	[date_id_estimated_delivery] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_customers]    Script Date: 27/05/2023 22:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_customers](
	[customer_id] [varchar](200) NOT NULL,
	[customer_city] [varchar](200) NOT NULL,
	[customer_state] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_products]    Script Date: 27/05/2023 22:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_products](
	[id_product] [varchar](200) NOT NULL,
	[seller_id] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_status]    Script Date: 27/05/2023 22:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_status](
	[status_id] [int] IDENTITY(100,100) NOT NULL,
	[status] [varchar](100) NOT NULL,
 CONSTRAINT [PK_dim_status] PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_time]    Script Date: 27/05/2023 22:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_time](
	[id_date] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NULL,
	[datetime] [datetime] NULL,
	[year] [int] NULL,
	[quarter] [int] NULL,
	[month] [int] NULL,
	[month_name] [varchar](100) NULL,
	[day_week] [int] NULL,
	[time] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facts_orders]    Script Date: 27/05/2023 22:37:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facts_orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [varchar](200) NOT NULL,
	[customer_id] [varchar](200) NOT NULL,
	[product_id] [varchar](200) NOT NULL,
	[price] [money] NOT NULL,
	[freight_value] [money] NOT NULL,
	[status_id] [int] NOT NULL,
	[date_id_purchase] [int] NULL,
	[date_id_delivered_carrier] [int] NULL,
	[date_id_delivered_customer] [int] NULL,
	[date_id_estimated_delivery] [int] NULL,
 CONSTRAINT [PK_Facts_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [Olist] SET  READ_WRITE 
GO
