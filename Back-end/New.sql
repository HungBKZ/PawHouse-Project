USE [master]
GO
/****** Object:  Database [PawHouseProjectHasData]    Script Date: 3/27/2025 12:30:00 AM ******/
CREATE DATABASE [PawHouseProjectHasData]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PawHouseProjectHasData', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PawHouseProjectHasData.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PawHouseProjectHasData_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PawHouseProjectHasData_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PawHouseProjectHasData] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PawHouseProjectHasData].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PawHouseProjectHasData] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET ARITHABORT OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PawHouseProjectHasData] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PawHouseProjectHasData] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PawHouseProjectHasData] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PawHouseProjectHasData] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PawHouseProjectHasData] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PawHouseProjectHasData] SET  MULTI_USER 
GO
ALTER DATABASE [PawHouseProjectHasData] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PawHouseProjectHasData] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PawHouseProjectHasData] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PawHouseProjectHasData] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PawHouseProjectHasData] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PawHouseProjectHasData] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PawHouseProjectHasData] SET QUERY_STORE = ON
GO
ALTER DATABASE [PawHouseProjectHasData] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PawHouseProjectHasData]
GO
/****** Object:  Table [dbo].[AdoptionHistory]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdoptionHistory](
	[AdoptionID] [int] IDENTITY(1,1) NOT NULL,
	[PetID] [int] NOT NULL,
	[AdoptionDate] [datetime] NULL,
	[AdoptionStatus] [nvarchar](20) NULL,
	[Notes] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[AdoptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[StaffID] [int] NULL,
	[DoctorID] [int] NULL,
	[PetID] [int] NULL,
	[ServiceID] [int] NOT NULL,
	[AppointmentDate] [datetime] NOT NULL,
	[BookingDate] [datetime] NULL,
	[AppointmentStatus] [nvarchar](20) NULL,
	[Notes] [nvarchar](500) NULL,
	[Price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[AddedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalRecords]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalRecords](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[PetID] [int] NOT NULL,
	[AppointmentID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
	[Diagnosis] [nvarchar](500) NULL,
	[Treatment] [nvarchar](500) NULL,
	[Prescription] [nvarchar](500) NULL,
	[VaccinationDetails] [nvarchar](500) NULL,
	[NextVaccinationDate] [datetime] NULL,
	[Weight] [decimal](5, 2) NULL,
	[Temperature] [decimal](4, 1) NULL,
	[Notes] [nvarchar](1000) NULL,
	[RecordDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[OrderStatus] [nvarchar](20) NULL,
	[Notes] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[AppointmentID] [int] NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[PaymentStatus] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PetCategories]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PetCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pets]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pets](
	[PetID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[PetName] [nvarchar](50) NULL,
	[Species] [nvarchar](50) NULL,
	[Breed] [nvarchar](50) NULL,
	[Age] [int] NULL,
	[Gender] [nvarchar](10) NULL,
	[PetImage] [nvarchar](255) NULL,
	[AdoptionStatus] [nvarchar](20) NULL,
	[UserID] [int] NULL,
	[InUseService] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[PetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Type] [nvarchar](75) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductComment]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductComment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Star] [int] NULL,
	[Content] [nvarchar](500) NULL,
	[Date_Comment] [datetime] NULL,
	[Image] [nvarchar](255) NULL,
	[ProductCommentStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[Stock] [int] NULL,
	[ProductImage] [nvarchar](255) NULL,
	[ProductStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceCategories]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Type] [nvarchar](75) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[ServiceID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ServiceName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[ServiceImage] [nvarchar](255) NULL,
	[ServiceStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/27/2025 12:30:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[Avatar] [nvarchar](255) NULL,
	[UserStatus] [bit] NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdoptionHistory] ON 

INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (1, 2, CAST(N'2024-01-15T00:00:00.000' AS DateTime), N'Hoàn thành', N'Chủ mới rất yêu thương và chăm sóc Whiskers.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (3, 7, CAST(N'2024-02-05T00:00:00.000' AS DateTime), N'Hoàn thành', N'Rocky đã được chủ mới huấn luyện cơ bản.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (4, 11, CAST(N'2023-11-30T00:00:00.000' AS DateTime), N'Hoàn thành', N'Simba có một ngôi nhà mới ấm cúng.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (5, 14, CAST(N'2024-01-10T00:00:00.000' AS DateTime), N'Hoàn thành', N'Choco đang phát triển khỏe mạnh trong gia đình mới.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (6, 16, CAST(N'2023-10-25T00:00:00.000' AS DateTime), N'Hoàn thành', N'Oliver được chủ mới đăng ký bảo hiểm thú cưng.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (7, 19, CAST(N'2024-02-01T00:00:00.000' AS DateTime), N'Hoàn thành', N'Shadow đã có môi trường sống ổn định và an toàn.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (8, 22, CAST(N'2023-09-12T00:00:00.000' AS DateTime), N'Hoàn thành', N'Sunny đã được chăm sóc tốt trong ngôi nhà mới.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (9, 25, CAST(N'2024-01-20T00:00:00.000' AS DateTime), N'Hoàn thành', N'Cooper rất năng động và thích chơi đùa với chủ mới.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (10, 27, CAST(N'2023-08-15T00:00:00.000' AS DateTime), N'Hoàn thành', N'Pumpkin được nuôi trong một ngôi nhà có nhiều mèo khác.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (11, 8, CAST(N'2025-03-18T22:34:00.020' AS DateTime), N'Hoàn thành', N'Luna được tạo kiểu lông phù hợp với giống và sở thích của chủ.')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (12, 10, CAST(N'2025-03-24T13:01:56.303' AS DateTime), N'Hoàn thành', N'Bạn có thể nhận nuôi em này!')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (13, 12, CAST(N'2025-03-25T16:08:18.727' AS DateTime), N'Từ chối', N'Max đã bị trùng lịch hẹn. Mong quý khách thông cảm!')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (14, 12, CAST(N'2025-03-25T16:10:14.463' AS DateTime), N'Từ chối', N'Max đã bị trùng lịch hẹn rồi. Mong quý khách thông cảm!')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (16, 15, CAST(N'2025-03-26T10:03:15.640' AS DateTime), N'Từ chối', N'Daisy đã bị trùng lịch hẹn rùi! Quý khách vui lòng chọn lịch khác')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (17, 3, CAST(N'2025-03-26T10:04:23.320' AS DateTime), N'Hoàn thành', N'Charlie đã được huấn luyện cơ bản')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (18, 18, CAST(N'2025-03-26T23:00:01.383' AS DateTime), N'Từ chối', N'Em này hiện đang chưa sẵn sàng')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (19, 18, CAST(N'2025-03-26T23:18:52.017' AS DateTime), N'Từ chối', N'Con này đang trong quá trình thăm khám')
INSERT [dbo].[AdoptionHistory] ([AdoptionID], [PetID], [AdoptionDate], [AdoptionStatus], [Notes]) VALUES (20, 17, CAST(N'2025-03-26T23:24:32.130' AS DateTime), N'Hoàn thành', N'Leo rất ngoan và khoẻ')
SET IDENTITY_INSERT [dbo].[AdoptionHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Appointments] ON 

INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (1, 24, 2, NULL, 19, 9, CAST(N'2025-03-15T14:00:00.000' AS DateTime), CAST(N'2025-04-03T15:00:00.000' AS DateTime), N'1', NULL, CAST(300000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (2, 25, NULL, 7, 22, 17, CAST(N'2025-02-16T08:36:00.000' AS DateTime), CAST(N'2025-03-15T14:00:00.000' AS DateTime), N'0', NULL, CAST(500000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (3, 27, NULL, 8, 25, 18, CAST(N'2025-02-25T18:30:00.000' AS DateTime), CAST(N'2025-03-14T11:00:00.000' AS DateTime), N'0', NULL, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (4, 28, 5, NULL, 27, 4, CAST(N'2025-02-03T10:00:00.000' AS DateTime), CAST(N'2025-03-13T12:00:00.000' AS DateTime), N'0', NULL, CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (8, 24, 3, NULL, 19, 2, CAST(N'2025-03-23T16:18:54.363' AS DateTime), CAST(N'2025-03-25T16:18:00.000' AS DateTime), N'1', NULL, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (9, 24, 2, NULL, 8, 2, CAST(N'2025-03-25T15:49:32.297' AS DateTime), CAST(N'2025-03-26T15:49:00.000' AS DateTime), N'0', NULL, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (10, 32, 5, NULL, 3, 2, CAST(N'2025-03-26T10:05:46.900' AS DateTime), CAST(N'2025-03-27T10:05:00.000' AS DateTime), N'0', NULL, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (12, 31, NULL, NULL, 10, 3, CAST(N'2025-03-26T23:01:43.433' AS DateTime), CAST(N'2025-03-28T23:01:00.000' AS DateTime), N'0', N'Hãy làm Snowball này thật đẹp', CAST(250000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (13, 31, NULL, NULL, 17, 2, CAST(N'2025-03-26T23:26:00.417' AS DateTime), CAST(N'2025-03-27T23:25:00.000' AS DateTime), N'0', N'hãy làm em thật xinh', CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (15, 31, NULL, NULL, 17, 5, CAST(N'2025-03-26T23:30:05.537' AS DateTime), CAST(N'2025-03-30T23:30:00.000' AS DateTime), N'0', N'', CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[Appointments] ([AppointmentID], [CustomerID], [StaffID], [DoctorID], [PetID], [ServiceID], [AppointmentDate], [BookingDate], [AppointmentStatus], [Notes], [Price]) VALUES (16, 31, NULL, NULL, 17, 5, CAST(N'2025-03-26T23:30:32.453' AS DateTime), CAST(N'2025-03-30T23:30:00.000' AS DateTime), N'0', N'', CAST(80000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Appointments] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity], [AddedDate]) VALUES (1, 12, 1, 2, CAST(N'2025-03-15T10:00:00.000' AS DateTime))
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity], [AddedDate]) VALUES (2, 14, 7, 1, CAST(N'2025-03-15T12:00:00.000' AS DateTime))
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity], [AddedDate]) VALUES (3, 16, 19, 3, CAST(N'2025-03-15T14:30:00.000' AS DateTime))
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity], [AddedDate]) VALUES (4, 18, 25, 1, CAST(N'2025-03-15T15:00:00.000' AS DateTime))
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity], [AddedDate]) VALUES (5, 20, 31, 2, CAST(N'2025-03-15T16:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicalRecords] ON 

INSERT [dbo].[MedicalRecords] ([RecordID], [PetID], [AppointmentID], [DoctorID], [Diagnosis], [Treatment], [Prescription], [VaccinationDetails], [NextVaccinationDate], [Weight], [Temperature], [Notes], [RecordDate]) VALUES (1, 25, 3, 8, N'Viêm da nhẹ', N'Bôi thuốc ngoài da', N'Kem bôi Betadine', NULL, NULL, CAST(5.50 AS Decimal(5, 2)), CAST(38.5 AS Decimal(4, 1)), N'Tránh tắm bằng sữa tắm người hoặc xà phòng mạnh, chỉ sử dụng dầu gội chuyên dụng cho thú cưng.', CAST(N'2025-03-14T11:30:00.000' AS DateTime))
INSERT [dbo].[MedicalRecords] ([RecordID], [PetID], [AppointmentID], [DoctorID], [Diagnosis], [Treatment], [Prescription], [VaccinationDetails], [NextVaccinationDate], [Weight], [Temperature], [Notes], [RecordDate]) VALUES (2, 22, 2, 7, N'Khỏe Mạnh', NULL, NULL, N'Tiêm phòng 7 bệnh cho chó', CAST(N'2025-06-15T14:05:00.000' AS DateTime), CAST(4.20 AS Decimal(5, 2)), CAST(39.0 AS Decimal(4, 1)), N'Cần theo dõi thêm', CAST(N'2025-03-15T14:05:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[MedicalRecords] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (1, 1, 1, 2, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (2, 2, 7, 1, CAST(180000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (3, 3, 19, 3, CAST(90000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (4, 4, 1, 1, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (5, 5, 1, 1, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (6, 5, 3, 1, CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (7, 6, 1, 1, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (8, 7, 1, 1, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (9, 8, 19, 1, CAST(90000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (10, 9, 20, 2, CAST(250000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (11, 10, 1, 1, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (12, 11, 1, 1, CAST(200000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (1, 12, CAST(N'2025-03-15T11:00:00.000' AS DateTime), CAST(400000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (2, 14, CAST(N'2025-03-15T13:00:00.000' AS DateTime), CAST(180000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (3, 16, CAST(N'2025-03-15T15:00:00.000' AS DateTime), CAST(270000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (4, 24, CAST(N'2025-03-23T12:11:25.450' AS DateTime), CAST(200000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (5, 24, CAST(N'2025-03-23T15:24:15.733' AS DateTime), CAST(300000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (6, 36, CAST(N'2025-03-23T18:21:17.917' AS DateTime), CAST(200000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (7, 31, CAST(N'2025-03-24T13:00:21.663' AS DateTime), CAST(200000.00 AS Decimal(10, 2)), N'0', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (8, 31, CAST(N'2025-03-24T13:01:34.793' AS DateTime), CAST(90000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (9, 31, CAST(N'2025-03-24T13:10:01.697' AS DateTime), CAST(500000.00 AS Decimal(10, 2)), N'0', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (10, 31, CAST(N'2025-03-25T15:14:52.470' AS DateTime), CAST(200000.00 AS Decimal(10, 2)), N'1', NULL)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [OrderStatus], [Notes]) VALUES (11, 32, CAST(N'2025-03-26T10:06:42.820' AS DateTime), CAST(200000.00 AS Decimal(10, 2)), N'1', NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (1, 2, NULL, CAST(180000.00 AS Decimal(10, 2)), CAST(N'2025-03-15T13:30:00.000' AS DateTime), N'Tiền mặt', N'1')
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (2, NULL, 1, CAST(300000.00 AS Decimal(10, 2)), CAST(N'2025-03-15T14:00:00.000' AS DateTime), N'Chuyển khoản', N'1')
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (3, 1, NULL, CAST(400000.00 AS Decimal(10, 2)), NULL, N'Tiền mặt', N'1')
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (4, 3, NULL, CAST(270000.00 AS Decimal(10, 2)), NULL, N'Tiền mặt', N'1')
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (5, NULL, 2, CAST(500000.00 AS Decimal(10, 2)), NULL, N'Tiền mặt', N'1')
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (6, NULL, 3, CAST(400000.00 AS Decimal(10, 2)), NULL, N'Chuyển khoản', N'1')
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [AppointmentID], [Amount], [PaymentDate], [PaymentMethod], [PaymentStatus]) VALUES (7, NULL, 4, CAST(50000.00 AS Decimal(10, 2)), NULL, N'Chuyển khoản', N'1')
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
SET IDENTITY_INSERT [dbo].[PetCategories] ON 

INSERT [dbo].[PetCategories] ([CategoryID], [CategoryName], [Description]) VALUES (1, N'Chó', N'Một số giống phổ biến: Husky, Poodle, Corgi, Labrador, Golden Retriever.')
INSERT [dbo].[PetCategories] ([CategoryID], [CategoryName], [Description]) VALUES (2, N'Mèo', N'Một số giống phổ biến: Mèo Anh lông ngắn, Mèo Ba Tư, Mèo Maine Coon, Mèo Scottish Fold, Mèo Bengal.')
INSERT [dbo].[PetCategories] ([CategoryID], [CategoryName], [Description]) VALUES (3, N'Bò sát', N'Nhóm động vật gồm rắn, rùa, thằn lằn, thường có da vảy và máu lạnh.')
INSERT [dbo].[PetCategories] ([CategoryID], [CategoryName], [Description]) VALUES (4, N'Gặm nhấm', N'Nhóm động vật nhỏ như chuột, hamster, thỏ, có răng cửa phát triển để gặm nhấm thức ăn.')
SET IDENTITY_INSERT [dbo].[PetCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Pets] ON 

INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (1, 1, N'Buddy', N'Chó', N'Golden Retriever', 3, N'Đực', N'imgs/pet/pet1.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (2, 2, N'Whiskers', N'Mèo', N'Maine Coon', 3, N'Cái', N'imgs/pet/pet2.jpg', N'Đã nhận nuôi', 12, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (3, 1, N'Charlie', N'Chó', N'Bulldog', 4, N'Đực', N'imgs/pet/pet3.jpg', N'Đã nhận nuôi', 32, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (4, 3, N'Spike', N'Bò sát', N'Rồng Nam Mỹ', 5, N'Đực', N'imgs/pet/pet4.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (5, 2, N'Milo', N'Mèo', N'Sphynx', 2, N'Đực', N'imgs/pet/pet5.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (6, 4, N'Nibbles', N'Gặm nhấm', N'Hamster', 1, N'Cái', N'imgs/pet/pet6.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (7, 1, N'Rocky', N'Chó', N'Husky', 3, N'Đực', N'imgs/pet/pet7.jpg', N'Đã nhận nuôi', 16, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (8, 2, N'Luna', N'Mèo', N'Bengal', 2, N'Cái', N'imgs/pet/pet8.jpg', N'Đã nhận nuôi', 24, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (9, 3, N'Echo', N'Bò sát', N'Tắc kè', 4, N'Cái', N'imgs/pet/pet9.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (10, 4, N'Snowball', N'Gặm nhấm', N'Chuột lang', 2, N'Đực', N'imgs/pet/pet10.jpg', N'Đã nhận nuôi', 31, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (11, 2, N'Simba', N'Mèo', N'Persian', 5, N'Đực', N'imgs/pet/pet11.jpg', N'Đã nhận nuôi', 18, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (12, 1, N'Max', N'Chó', N'Labrador', 3, N'Đực', N'imgs/pet/pet12.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (13, 3, N'Iggy', N'Bò sát', N'Iguana', 6, N'Đực', N'imgs/pet/pet13.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (14, 4, N'Choco', N'Gặm nhấm', N'Guinea Pig', 1, N'Cái', N'imgs/pet/pet14.jpg', N'Đã nhận nuôi', 20, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (15, 1, N'Daisy', N'Chó', N'Beagle', 2, N'Cái', N'imgs/pet/pet15.jpg', N'Chưa nhận nuôi', 32, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (16, 2, N'Oliver', N'Mèo', N'Ragdoll', 3, N'Đực', N'imgs/pet/pet16.jpg', N'Đã nhận nuôi', 21, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (17, 3, N'Leo', N'Bò sát', N'Rùa cảnh', 8, N'Đực', N'imgs/pet/pet17.jpg', N'Đã nhận nuôi', 31, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (18, 1, N'Zoe', N'Chó', N'Poodle', 4, N'Cái', N'imgs/pet/pet18.jpg', N'Chưa nhận nuôi', 31, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (19, 2, N'Shadow', N'Mèo', N'Siamese', 5, N'Đực', N'imgs/pet/pet19.jpg', N'Đã nhận nuôi', 24, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (20, 4, N'Peanut', N'Gặm nhấm', N'Chuột đồng', 1, N'Cái', N'imgs/pet/pet20.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (21, 1, N'Bruno', N'Chó', N'Doberman', 3, N'Đực', N'imgs/pet/pet21.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (22, 3, N'Sunny', N'Bò sát', N'Tắc kè đuôi béo', 4, N'Cái', N'imgs/pet/pet22.png', N'Đã nhận nuôi', 25, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (23, 4, N'Cinnamon', N'Gặm nhấm', N'Hamster', 2, N'Đực', N'imgs/pet/pet23.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (24, 2, N'Misty', N'Mèo', N'Scottish Fold', 3, N'Cái', N'imgs/pet/pet24.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (25, 1, N'Cooper', N'Chó', N'Shiba Inu', 2, N'Đực', N'imgs/pet/pet25.jpg', N'Đã nhận nuôi', 27, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (26, 3, N'Rex', N'Bò sát', N'Rồng Úc', 6, N'Đực', N'imgs/pet/pet26.png', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (27, 2, N'Pumpkin', N'Mèo', N'Abyssinian', 4, N'Cái', N'imgs/pet/pet27.jpg', N'Đã nhận nuôi', 28, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (30, 2, N'CatMi', N'Mèo', N'Mèo Anh đuôi dài', 3, N'Cái', N'imgs/pet/pet11.jpg', N'Chưa nhận nuôi', NULL, NULL)
INSERT [dbo].[Pets] ([PetID], [CategoryID], [PetName], [Species], [Breed], [Age], [Gender], [PetImage], [AdoptionStatus], [UserID], [InUseService]) VALUES (31, 2, N'Meow', N'Mèo', N'Mèo Anh đuôi cụt', 3, N'Đực', N'imgs/pet/pet27.jpg', N'Chưa nhận nuôi', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Pets] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] ON 

INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (1, N'Thức ăn cho chó', N'Các loại thức ăn dinh dưỡng dành cho chó ở mọi độ tuổi.', N'Thức Ăn')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (2, N'Thức ăn cho mèo', N'Thức ăn dành cho mèo với nhiều hương vị và chất dinh dưỡng.', N'Thức Ăn')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (3, N'Thức ăn cho bò sát', N'Thức ăn chuyên dụng cho các loài bò sát như rùa, thằn lằn, rắn.', N'Thức Ăn')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (4, N'Bát ăn, khay ăn', N'Bát ăn và khay ăn dành cho thú cưng, chống tràn và dễ vệ sinh.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (5, N'Sữa tắm, dầu gội', N'Các loại sữa tắm và dầu gội giúp thú cưng có bộ lông sạch và khỏe mạnh.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (6, N'Cát vệ sinh cho mèo', N'Cát vệ sinh giúp kiểm soát mùi và giữ sạch môi trường sống của mèo.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (7, N'Phụ kiện thời trang', N'Nơ, băng đô, phụ kiện làm đẹp cho thú cưng.', N'Phụ Kiện')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (8, N'Ba lô, túi vận chuyển', N'Túi và ba lô giúp vận chuyển thú cưng dễ dàng và an toàn.', N'Phụ Kiện')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (9, N'Dây dắt, vòng cổ, rọ mõm', N'Phụ kiện hỗ trợ kiểm soát thú cưng khi đi dạo hoặc huấn luyện.', N'Phụ Kiện')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (10, N'Đồ chơi tương tác', N'Đồ chơi giúp thú cưng vui chơi và vận động nhiều hơn.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (11, N'Đồ chơi nhai', N'Đồ chơi giúp thú cưng nhai, giảm căng thẳng và làm sạch răng miệng.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (12, N'Bỉm, lót vệ sinh, túi phân', N'Sản phẩm hỗ trợ vệ sinh cho thú cưng, giúp giữ môi trường sạch sẽ.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (13, N'Dụng cụ sưởi ấm và đèn UV', N'Giúp bò sát duy trì nhiệt độ phù hợp để sinh trưởng.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (14, N'Sản phẩm chăm sóc bò sát', N'Dung dịch khử trùng, vitamin, thuốc bổ sung dinh dưỡng cho bò sát.', N'Đồ Dùng')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (15, N'Thức ăn cho chuột', N'Thức ăn dinh dưỡng cho chuột hamster, chuột bạch, guinea pig và nhím kiểng.', N'Thức Ăn')
SET IDENTITY_INSERT [dbo].[ProductCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductComment] ON 

INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (2, 12, 1, 5, N'Thức ăn hạt rất tốt, chó nhà mình rất thích.', CAST(N'2024-02-01T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (3, 12, 2, 4, N'Pate thơm ngon nhưng hơi đắt.', CAST(N'2024-02-03T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (4, 13, 3, 5, N'Xương gặm giúp chó sạch răng, rất hữu ích.', CAST(N'2024-01-25T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (5, 14, 4, 4, N'Snack huấn luyện hiệu quả, chó ăn ngon miệng.', CAST(N'2024-01-28T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (6, 14, 5, 3, N'Thức ăn ướt hơi ít so với giá.', CAST(N'2024-02-05T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (7, 15, 6, 5, N'Bột sữa dinh dưỡng tốt cho chó mẹ, bé con bú khỏe.', CAST(N'2024-02-10T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (8, 16, 7, 5, N'Thức ăn hạt giúp mèo nhà mình lông bóng mượt.', CAST(N'2024-01-20T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (9, 16, 8, 4, N'Pate ngon nhưng có mùi hơi nặng.', CAST(N'2024-02-01T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (10, 17, 9, 5, N'Snack huấn luyện mèo khá hiệu quả.', CAST(N'2024-02-05T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (11, 18, 10, 4, N'Sữa dinh dưỡng tốt nhưng hơi đặc.', CAST(N'2024-01-18T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (12, 19, 11, 5, N'Cỏ mèo giúp giảm búi lông rất tốt.', CAST(N'2024-02-09T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (13, 20, 12, 4, N'Thức ăn ướt ngon nhưng mèo nhà mình không thích lắm.', CAST(N'2024-02-12T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (14, 20, 13, 5, N'Thức ăn cho rùa rất tốt, rùa nhà mình ăn nhiều.', CAST(N'2024-02-15T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (15, 21, 14, 4, N'Cám dưỡng chất giúp rồng Nam Mỹ phát triển tốt.', CAST(N'2024-01-23T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (16, 22, 15, 5, N'Thức ăn khô cho trăn rất tiện lợi.', CAST(N'2024-01-30T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (17, 23, 16, 4, N'Dế sấy khô tươi ngon, bò sát rất thích.', CAST(N'2024-02-08T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (18, 24, 17, 5, N'Sâu gạo tươi ngon, rồng Nam Mỹ ăn khỏe.', CAST(N'2024-02-04T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (19, 25, 18, 5, N'Thức ăn đông lạnh rất sạch và dễ bảo quản.', CAST(N'2024-01-19T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (20, 26, 19, 4, N'Bát ăn chống tràn rất hữu ích.', CAST(N'2024-02-07T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (21, 27, 20, 5, N'Bát ăn tự động rất tiện lợi khi đi xa.', CAST(N'2024-01-27T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (22, 27, 21, 5, N'Khay ăn inox chất lượng cao.', CAST(N'2024-02-02T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (23, 28, 22, 4, N'Khay ăn đôi phù hợp cho nhà có nhiều thú cưng.', CAST(N'2024-02-06T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (24, 35, 19, 5, N'Bát ăn chống tràn rất hữu ích.', CAST(N'2025-03-15T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductComment] ([CommentID], [UserID], [ProductID], [Star], [Content], [Date_Comment], [Image], [ProductCommentStatus]) VALUES (25, 31, 19, 1, N'Bát ăn bị tràn rất tệ.', CAST(N'2025-03-15T00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[ProductComment] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (1, 1, N'Thức ăn hạt cao cấp', N'Thức ăn hạt cho chó con và chó trưởng thành, giàu dinh dưỡng.', CAST(200000.00 AS Decimal(10, 2)), 38, N'imgs/product/product1.jpg', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (2, 1, N'Pate cho chó', N'Pate mềm dành cho chó nhỏ và chó lớn, giúp dễ tiêu hóa.', CAST(150000.00 AS Decimal(10, 2)), 38, N'imgs/product/product2.jpg', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (3, 1, N'Xương gặm dinh dưỡng', N'Xương gặm giúp làm sạch răng và bổ sung canxi.', CAST(100000.00 AS Decimal(10, 2)), 58, N'imgs/product/product3.png', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (4, 1, N'Snack huấn luyện', N'Snack nhỏ gọn, phù hợp cho việc huấn luyện chó.', CAST(80000.00 AS Decimal(10, 2)), 79, N'imgs/product/product4.jpg', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (5, 1, N'Thức ăn ướt cho chó', N'Dạng ướt, phù hợp với chó kén ăn.', CAST(180000.00 AS Decimal(10, 2)), 35, N'imgs/product/product5.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (6, 1, N'Bột sữa dinh dưỡng', N'Bổ sung dưỡng chất cho chó mẹ và chó con.', CAST(220000.00 AS Decimal(10, 2)), 25, N'imgs/product/product6.png', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (7, 2, N'Thức ăn hạt cao cấp', N'Thức ăn hạt giàu protein và taurine giúp mèo khỏe mạnh.', CAST(180000.00 AS Decimal(10, 2)), 45, N'imgs/product/product7.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (8, 2, N'Pate cho mèo', N'Pate thơm ngon, bổ dưỡng cho mèo ở mọi độ tuổi.', CAST(130000.00 AS Decimal(10, 2)), 50, N'imgs/product/product8.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (9, 2, N'Snack thưởng', N'Snack dạng viên nhỏ giúp huấn luyện mèo dễ dàng.', CAST(90000.00 AS Decimal(10, 2)), 70, N'imgs/product/product9.webp', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (10, 2, N'Sữa dinh dưỡng', N'Sữa bổ sung canxi và vitamin dành riêng cho mèo.', CAST(200000.00 AS Decimal(10, 2)), 30, N'imgs/product/product10.png', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (11, 2, N'Cỏ mèo sấy khô', N'Cỏ mèo giúp kích thích hệ tiêu hóa và giảm búi lông.', CAST(60000.00 AS Decimal(10, 2)), 90, N'imgs/product/product11.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (12, 2, N'Thức ăn ướt cho mèo', N'Thức ăn ướt hương vị cá hồi, gà, bò.', CAST(170000.00 AS Decimal(10, 2)), 40, N'imgs/product/product12.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (13, 3, N'Thức ăn cho rùa', N'Thức ăn viên chuyên dụng cho rùa cảnh.', CAST(120000.00 AS Decimal(10, 2)), 50, N'imgs/product/product13.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (14, 3, N'Cám dưỡng chất', N'Cám chứa protein cao, phù hợp với rồng Nam Mỹ.', CAST(150000.00 AS Decimal(10, 2)), 40, N'imgs/product/product14.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (15, 3, N'Thức ăn khô cho trăn', N'Thức ăn khô cung cấp đủ dinh dưỡng.', CAST(200000.00 AS Decimal(10, 2)), 35, N'imgs/product/product15.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (16, 3, N'Dế sấy khô', N'Dế sấy khô bổ sung đạm cho bò sát.', CAST(90000.00 AS Decimal(10, 2)), 60, N'imgs/product/product16.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (17, 3, N'Sâu gạo sống', N'Nguồn thức ăn tươi giàu đạm.', CAST(110000.00 AS Decimal(10, 2)), 45, N'imgs/product/product17.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (18, 3, N'Thức ăn đông lạnh', N'Thực phẩm đông lạnh đảm bảo vệ sinh.', CAST(220000.00 AS Decimal(10, 2)), 30, N'imgs/product/product18.avif', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (19, 4, N'Bát ăn chống tràn', N'Bát thiết kế chống tràn, chống lật.', CAST(90000.00 AS Decimal(10, 2)), 37, N'imgs/product/product19.jpg', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (20, 4, N'Bát ăn tự động', N'Bát ăn tự động giúp điều chỉnh lượng thức ăn.', CAST(250000.00 AS Decimal(10, 2)), 18, N'imgs/product/product20.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (21, 4, N'Khay ăn inox', N'Khay ăn bằng inox chống rỉ sét.', CAST(120000.00 AS Decimal(10, 2)), 30, N'imgs/product/product21.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (22, 4, N'Khay ăn đôi', N'Khay ăn đôi cho thú cưng có thể dùng nước và thức ăn.', CAST(160000.00 AS Decimal(10, 2)), 25, N'imgs/product/product22.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (23, 4, N'Máy cho ăn tự động', N'Máy cho ăn có chế độ hẹn giờ.', CAST(500000.00 AS Decimal(10, 2)), 10, N'imgs/product/product23.webp', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (24, 4, N'Bình nước uống', N'Bình nước tự động cho thú cưng.', CAST(130000.00 AS Decimal(10, 2)), 40, N'imgs/product/product24.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (25, 5, N'Sữa tắm dưỡng lông', N'Sữa tắm giúp lông mềm mượt.', CAST(150000.00 AS Decimal(10, 2)), 50, N'imgs/product/product25.png', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (26, 5, N'Sữa tắm trị ve', N'Sữa tắm diệt ve, rận, bọ chét.', CAST(180000.00 AS Decimal(10, 2)), 45, N'imgs/product/product26.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (27, 5, N'Dầu gội khử mùi', N'Dầu gội giúp khử mùi hôi.', CAST(170000.00 AS Decimal(10, 2)), 35, N'imgs/product/product27.jpeg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (28, 5, N'Sữa tắm hữu cơ', N'Thành phần thiên nhiên, an toàn.', CAST(200000.00 AS Decimal(10, 2)), 25, N'imgs/product/product28.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (29, 5, N'Dầu xả dưỡng ẩm', N'Dưỡng ẩm giúp lông không bị khô.', CAST(140000.00 AS Decimal(10, 2)), 40, N'imgs/product/product29.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (30, 5, N'Dung dịch vệ sinh tai', N'Giúp làm sạch tai, ngăn ngừa vi khuẩn.', CAST(120000.00 AS Decimal(10, 2)), 30, N'imgs/product/product30.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (31, 6, N'Cát vệ sinh không bụi', N'Hạn chế bụi giúp mèo không bị hắt hơi.', CAST(180000.00 AS Decimal(10, 2)), 50, N'imgs/product/product31.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (32, 6, N'Cát vón cục nhanh', N'Cát vón nhanh giúp dễ dọn dẹp.', CAST(200000.00 AS Decimal(10, 2)), 45, N'imgs/product/product32.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (33, 6, N'Cát hữu cơ', N'Cát làm từ đậu nành, an toàn.', CAST(250000.00 AS Decimal(10, 2)), 35, N'imgs/product/product33.jpeg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (34, 6, N'Cát thơm khử mùi', N'Hương thơm giúp loại bỏ mùi hôi.', CAST(190000.00 AS Decimal(10, 2)), 40, N'imgs/product/product34.webp', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (35, 6, N'Cát vệ sinh giá rẻ', N'Dành cho mèo nhiều con, tiết kiệm.', CAST(120000.00 AS Decimal(10, 2)), 60, N'imgs/product/product35.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (36, 6, N'Cát không vón cục', N'Không vón cục, dễ dàng làm sạch.', CAST(150000.00 AS Decimal(10, 2)), 30, N'imgs/product/product36.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (37, 7, N'Nơ cổ', N'Nơ cổ giúp thú cưng sang trọng.', CAST(50000.00 AS Decimal(10, 2)), 58, N'imgs/product/product37.jpg', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (38, 7, N'Băng đô', N'Băng đô dễ thương cho mèo, chó.', CAST(80000.00 AS Decimal(10, 2)), 50, N'imgs/product/product38.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (39, 7, N'Kính mắt thời trang', N'Kính bảo vệ mắt thú cưng.', CAST(150000.00 AS Decimal(10, 2)), 25, N'imgs/product/product39.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (40, 7, N'Áo vest chó mèo', N'Áo vest lịch lãm cho thú cưng.', CAST(200000.00 AS Decimal(10, 2)), 30, N'imgs/product/product40.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (41, 7, N'Dây buộc tóc', N'Dây buộc tóc dễ thương.', CAST(40000.00 AS Decimal(10, 2)), 70, N'imgs/product/product41.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (42, 7, N'Vòng cổ thời trang', N'Vòng cổ lấp lánh, sang trọng.', CAST(130000.00 AS Decimal(10, 2)), 40, N'imgs/product/product42.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (43, 8, N'Balo phi hành gia', N'Balo có cửa sổ trong suốt.', CAST(400000.00 AS Decimal(10, 2)), 20, N'imgs/product/product43.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (44, 8, N'Túi vận chuyển gấp gọn', N'Túi nhẹ, dễ gấp gọn.', CAST(300000.00 AS Decimal(10, 2)), 25, N'imgs/product/product44.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (45, 8, N'Túi đeo chéo', N'Tiện lợi khi đi dạo.', CAST(250000.00 AS Decimal(10, 2)), 30, N'imgs/product/product45.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (46, 8, N'Giỏ vận chuyển có nắp', N'Giỏ nhựa bền chắc.', CAST(200000.00 AS Decimal(10, 2)), 40, N'imgs/product/product46.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (47, 8, N'Balo có quạt', N'Giúp thú cưng mát mẻ.', CAST(500000.00 AS Decimal(10, 2)), 15, N'imgs/product/product47.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (48, 8, N'Xe đẩy thú cưng', N'Xe đẩy tiện dụng.', CAST(700000.00 AS Decimal(10, 2)), 10, N'imgs/product/product48.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (49, 9, N'Dây dắt da', N'Dây chắc chắn, bền đẹp.', CAST(150000.00 AS Decimal(10, 2)), 40, N'imgs/product/product49.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (50, 9, N'Dây dắt tự cuốn', N'Tiện lợi khi đi dạo.', CAST(250000.00 AS Decimal(10, 2)), 30, N'imgs/product/product50.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (51, 9, N'Vòng cổ phản quang', N'Phản quang giúp an toàn.', CAST(100000.00 AS Decimal(10, 2)), 50, N'imgs/product/product51.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (52, 9, N'Vòng cổ chống ve', N'Bảo vệ thú cưng khỏi ve.', CAST(180000.00 AS Decimal(10, 2)), 35, N'imgs/product/product52.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (53, 9, N'Rọ mõm nhựa', N'Nhẹ, thoải mái.', CAST(120000.00 AS Decimal(10, 2)), 40, N'imgs/product/product53.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (54, 9, N'Rọ mõm da', N'Chắc chắn, bền.', CAST(160000.00 AS Decimal(10, 2)), 30, N'imgs/product/product54.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (55, 10, N'Bóng cao su', N'Bóng cao su dẻo dai, giúp thú cưng vui chơi.', CAST(100000.00 AS Decimal(10, 2)), 50, N'imgs/product/product55.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (56, 10, N'Chuột bông cho mèo', N'Đồ chơi hình chuột giúp kích thích bản năng săn mồi.', CAST(80000.00 AS Decimal(10, 2)), 40, N'imgs/product/product56.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (57, 10, N'Cây lăn bóng', N'Đồ chơi thông minh, thú cưng tự chơi.', CAST(120000.00 AS Decimal(10, 2)), 30, N'imgs/product/product57.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (58, 10, N'Bóng phát sáng', N'Bóng tự phát sáng khi lăn.', CAST(150000.00 AS Decimal(10, 2)), 35, N'imgs/product/product58.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (59, 10, N'Đĩa bay cho chó', N'Đĩa bay giúp chó vận động.', CAST(90000.00 AS Decimal(10, 2)), 45, N'imgs/product/product59.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (60, 10, N'Trụ cào móng', N'Trụ cào giúp mèo không cào đồ đạc.', CAST(250000.00 AS Decimal(10, 2)), 20, N'imgs/product/product60.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (61, 11, N'Xương gặm cao su', N'Xương gặm giúp làm sạch răng.', CAST(90000.00 AS Decimal(10, 2)), 40, N'imgs/product/product61.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (62, 11, N'Bánh quy gặm', N'Bánh quy thơm ngon cho chó.', CAST(120000.00 AS Decimal(10, 2)), 30, N'imgs/product/product62.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (63, 11, N'Dây thừng gặm', N'Dây thừng bền giúp chó nhai lâu.', CAST(150000.00 AS Decimal(10, 2)), 25, N'imgs/product/product63.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (64, 11, N'Gậy gặm cao su', N'Thiết kế mềm mại giúp thú cưng nhai.', CAST(80000.00 AS Decimal(10, 2)), 50, N'imgs/product/product64.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (65, 11, N'Bánh xương tủy', N'Xương gặm dinh dưỡng cho chó.', CAST(100000.00 AS Decimal(10, 2)), 35, N'imgs/product/product65.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (66, 11, N'Bóng nhai mềm', N'Bóng mềm giúp chó nhai vui chơi.', CAST(110000.00 AS Decimal(10, 2)), 40, N'imgs/product/product66.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (67, 12, N'Bỉm quần cho chó', N'Bỉm quần thấm hút tốt.', CAST(150000.00 AS Decimal(10, 2)), 30, N'imgs/product/product67.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (68, 12, N'Bỉm dán cho mèo', N'Bỉm dán tiện lợi.', CAST(130000.00 AS Decimal(10, 2)), 25, N'imgs/product/product68.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (69, 12, N'Thảm vệ sinh thấm hút', N'Thảm giúp hấp thụ nước tiểu.', CAST(200000.00 AS Decimal(10, 2)), 20, N'imgs/product/product69.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (70, 12, N'Túi nhặt phân', N'Túi dễ phân hủy.', CAST(50000.00 AS Decimal(10, 2)), 50, N'imgs/product/product70.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (71, 12, N'Tấm lót siêu thấm', N'Lót giúp giữ vệ sinh.', CAST(120000.00 AS Decimal(10, 2)), 30, N'imgs/product/product71.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (72, 12, N'Hộp đựng túi phân', N'Hộp tiện lợi mang theo.', CAST(80000.00 AS Decimal(10, 2)), 40, N'imgs/product/product72.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (73, 13, N'Bóng đèn UV', N'Bóng UV giúp bò sát phát triển.', CAST(250000.00 AS Decimal(10, 2)), 20, N'imgs/product/product73.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (74, 13, N'Thảm sưởi bò sát', N'Giữ ấm cho bò sát vào mùa lạnh.', CAST(300000.00 AS Decimal(10, 2)), 15, N'imgs/product/product74.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (75, 13, N'Đèn nhiệt gắn lồng', N'Đèn nhiệt cung cấp ánh sáng.', CAST(200000.00 AS Decimal(10, 2)), 25, N'imgs/product/product75.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (76, 13, N'Gốm giữ nhiệt', N'Gốm giữ nhiệt tự nhiên.', CAST(180000.00 AS Decimal(10, 2)), 30, N'imgs/product/product76.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (77, 13, N'Máy sưởi mini', N'Máy sưởi tiết kiệm điện.', CAST(400000.00 AS Decimal(10, 2)), 10, N'imgs/product/product77.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (78, 13, N'Tấm giữ nhiệt', N'Tấm giữ nhiệt giúp ổn định nhiệt độ.', CAST(350000.00 AS Decimal(10, 2)), 12, N'imgs/product/product78.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (79, 14, N'Dung dịch khử trùng', N'Vệ sinh lồng nuôi.', CAST(100000.00 AS Decimal(10, 2)), 35, N'imgs/product/product79.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (80, 14, N'Vitamin bổ sung', N'Vitamin giúp bò sát phát triển.', CAST(120000.00 AS Decimal(10, 2)), 25, N'imgs/product/product80.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (81, 14, N'Thuốc phòng bệnh', N'Ngăn ngừa bệnh tật.', CAST(200000.00 AS Decimal(10, 2)), 20, N'imgs/product/product81.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (82, 14, N'Gel dưỡng da bò sát', N'Chống bong tróc da.', CAST(180000.00 AS Decimal(10, 2)), 30, N'imgs/product/product82.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (83, 14, N'Dung dịch làm sạch mắt', N'Giúp mắt bò sát luôn sạch.', CAST(150000.00 AS Decimal(10, 2)), 25, N'imgs/product/product83.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (84, 14, N'Xịt chống côn trùng', N'Ngăn muỗi, ruồi tiếp xúc.', CAST(130000.00 AS Decimal(10, 2)), 30, N'imgs/product/product84.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (85, 15, N'Hạt dinh dưỡng', N'Thức ăn hạt tổng hợp cho chuột hamster, chuột bạch.', CAST(120000.00 AS Decimal(10, 2)), 40, N'imgs/product/product85.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (86, 15, N'Pate chuột', N'Pate mềm bổ dưỡng cho chuột.', CAST(90000.00 AS Decimal(10, 2)), 50, N'imgs/product/product86.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (87, 15, N'Snack gặm nhấm', N'Snack giúp bổ sung khoáng chất cho chuột.', CAST(70000.00 AS Decimal(10, 2)), 60, N'imgs/product/product87.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (88, 15, N'Bột sữa cho chuột', N'Bổ sung canxi và protein giúp chuột phát triển.', CAST(150000.00 AS Decimal(10, 2)), 35, N'imgs/product/product88.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (89, 15, N'Cỏ khô Timothy', N'Cỏ khô tự nhiên, tốt cho tiêu hóa của chuột.', CAST(100000.00 AS Decimal(10, 2)), 45, N'imgs/product/product89.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Description], [Price], [Stock], [ProductImage], [ProductStatus]) VALUES (90, 15, N'Thức ăn viên hỗn hợp', N'Kết hợp hạt ngũ cốc và rau củ giàu dinh dưỡng.', CAST(130000.00 AS Decimal(10, 2)), 30, N'imgs/product/product90.jpg', 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Customer')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Staff')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (4, N'Doctor')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[ServiceCategories] ON 

INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (1, N'Chăm sóc lông', N'Dịch vụ tắm, cắt tỉa lông, tạo kiểu cho thú cưng.', N'Spa & Grooming')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (2, N'Vệ sinh', N'Vệ sinh tai, cắt móng, làm sạch tuyến hôi cho thú cưng.', N'Spa & Grooming')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (3, N'Huấn luyện', N'Đào tạo kỹ năng cơ bản và nâng cao cho chó, mèo.', N'Spa & Grooming')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (4, N'Giữ thú cưng', N'Dịch vụ khách sạn cho thú cưng khi chủ vắng nhà.', N'Spa & Grooming')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (5, N'Massage & Thư giãn', N'Massage thư giãn, giảm căng thẳng cho thú cưng.', N'Spa & Grooming')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (7, N'Khám tổng quát', N'Kiểm tra sức khỏe định kỳ cho thú cưng.', N'Thú y')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (8, N'Tiêm phòng', N'Tiêm phòng các loại vaccine quan trọng cho thú cưng.', N'Thú y')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (9, N'Chữa bệnh', N'Chẩn đoán và điều trị bệnh cho thú cưng.', N'Thú y')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (10, N'Phẫu thuật', N'Phẫu thuật triệt sản, loại bỏ khối u, điều trị chấn thương.', N'Thú y')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (11, N'Xét nghiệm', N'Xét nghiệm máu, nước tiểu, xét nghiệm bệnh truyền nhiễm.', N'Thú y')
INSERT [dbo].[ServiceCategories] ([CategoryID], [CategoryName], [Description], [Type]) VALUES (12, N'Nha khoa', N'Kiểm tra răng miệng, làm sạch cao răng cho thú cưng.', N'Thú y')
SET IDENTITY_INSERT [dbo].[ServiceCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (1, 1, N'Tắm thú cưng', N'Tắm bằng sữa tắm chuyên dụng giúp làm sạch và khử mùi.', CAST(150000.00 AS Decimal(10, 2)), N'imgs/service/service1.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (2, 1, N'Cắt tỉa lông', N'Tạo kiểu lông phù hợp với giống và sở thích của chủ.', CAST(200000.00 AS Decimal(10, 2)), N'imgs/service/service2.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (3, 1, N'Nhuộm lông', N'Sử dụng thuốc nhuộm an toàn, không gây kích ứng da.', CAST(250000.00 AS Decimal(10, 2)), N'imgs/service/service3.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (4, 2, N'Cắt móng', N'Cắt móng an toàn, tránh làm tổn thương thú cưng.', CAST(50000.00 AS Decimal(10, 2)), N'imgs/service/service4.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (5, 2, N'Vệ sinh tai', N'Làm sạch tai, loại bỏ bụi bẩn và phòng ngừa nhiễm trùng.', CAST(80000.00 AS Decimal(10, 2)), N'imgs/service/service5.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (6, 2, N'Làm sạch tuyến hôi', N'Giúp thú cưng không còn mùi khó chịu.', CAST(100000.00 AS Decimal(10, 2)), N'imgs/service/service6.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (7, 3, N'Huấn luyện cơ bản', N'Dạy thú cưng các lệnh cơ bản như ngồi, nằm, bắt tay.', CAST(500000.00 AS Decimal(10, 2)), N'imgs/service/service7.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (8, 3, N'Huấn luyện nâng cao', N'Training chuyên sâu dành cho chó nghiệp vụ.', CAST(1000000.00 AS Decimal(10, 2)), N'imgs/service/service8.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (9, 4, N'Khách sạn thú cưng (1 ngày)', N'Chăm sóc toàn diện cho thú cưng khi chủ vắng nhà.', CAST(300000.00 AS Decimal(10, 2)), N'imgs/service/service9.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (10, 4, N'Chăm sóc theo giờ', N'Dịch vụ trông giữ thú cưng theo giờ tại cửa hàng.', CAST(80000.00 AS Decimal(10, 2)), N'imgs/service/service10.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (11, 5, N'Massage thư giãn', N'Giúp thú cưng giảm căng thẳng, thư giãn cơ bắp.', CAST(180000.00 AS Decimal(10, 2)), N'imgs/service/service11.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (12, 5, N'Trị liệu vật lý', N'Hỗ trợ thú cưng phục hồi sau chấn thương.', CAST(250000.00 AS Decimal(10, 2)), N'imgs/service/service12.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (15, 7, N'Khám sức khỏe định kỳ', N'Kiểm tra tổng quát và tư vấn dinh dưỡng.', CAST(300000.00 AS Decimal(10, 2)), N'imgs/service/service15.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (16, 8, N'Tiêm phòng dại', N'Vaccine phòng bệnh dại cho chó mèo.', CAST(250000.00 AS Decimal(10, 2)), N'imgs/service/service16.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (17, 8, N'Tiêm phòng 7 bệnh', N'Vaccine phòng bệnh care, pravo, viêm gan,...', CAST(500000.00 AS Decimal(10, 2)), N'imgs/service/service17.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (18, 9, N'Điều trị viêm da', N'Chẩn đoán và điều trị các bệnh ngoài da cho thú cưng.', CAST(400000.00 AS Decimal(10, 2)), N'imgs/service/service18.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (19, 9, N'Chữa bệnh tiêu hóa', N'Xử lý các vấn đề tiêu hóa như tiêu chảy, táo bón.', CAST(350000.00 AS Decimal(10, 2)), N'imgs/service/service19.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (20, 10, N'Triệt sản', N'Phẫu thuật triệt sản cho chó đực hoặc cái.', CAST(1200000.00 AS Decimal(10, 2)), N'imgs/service/service20.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (21, 10, N'Phẫu thuật lấy dị vật', N'Loại bỏ dị vật trong dạ dày thú cưng.', CAST(2000000.00 AS Decimal(10, 2)), N'imgs/service/service21.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (22, 11, N'Xét nghiệm máu', N'Xác định tình trạng sức khỏe tổng quát.', CAST(350000.00 AS Decimal(10, 2)), N'imgs/service/service22.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (23, 11, N'Xét nghiệm ký sinh trùng', N'Kiểm tra ve, giun sán trong cơ thể thú cưng.', CAST(300000.00 AS Decimal(10, 2)), N'imgs/service/service23.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (24, 12, N'Làm sạch răng', N'Loại bỏ cao răng giúp răng thú cưng chắc khỏe.', CAST(400000.00 AS Decimal(10, 2)), N'imgs/service/service24.jpg', 1)
INSERT [dbo].[Services] ([ServiceID], [CategoryID], [ServiceName], [Description], [Price], [ServiceImage], [ServiceStatus]) VALUES (25, 12, N'Nhổ răng sâu', N'Nhổ bỏ răng bị hỏng để tránh nhiễm trùng.', CAST(500000.00 AS Decimal(10, 2)), N'imgs/service/service25.jpg', 1)
SET IDENTITY_INSERT [dbo].[Services] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (1, 1, N'ThanhHung', N'E6E061838856BF47E1DE730719FB2609', N'PhanThanhHung@gmail.com', N'Phan Thành Hưng', N'0912345678', N'imgs/avatar/avatar1.jpg', 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (2, 3, N'ChanHung', N'29353F3B5EB749AE0AFB3D88B810F05C', N'ChanHung@gmail.com', N'Nguyễn Huỳnh Chấn Hưng', N'0923456781', N'imgs/avatar/avatar2.jpg', 1, N'Bình Thủy, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (3, 3, N'HuyVo', N'29353F3B5EB749AE0AFB3D88B810F05C', N'ChanhHuy@gmail.com', N'Võ Chánh Huy', N'0923456782', NULL, 1, N'Cái Răng, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (4, 3, N'PhuHung', N'29353F3B5EB749AE0AFB3D88B810F05C', N'PhuHung@gmail.com', N'Phan Thành Hưng', N'0923456783', NULL, 1, N'Thốt Nốt, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (5, 3, N'buivane', N'29353F3B5EB749AE0AFB3D88B810F05C', N'buivane@gmail.com', N'Bùi Văn E', N'0923456784', NULL, 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (6, 3, N'nguyenthif', N'29353F3B5EB749AE0AFB3D88B810F05C', N'nguyenthif@gmail.com', N'Nguyễn Thị F', N'0923456785', NULL, 1, N'Ô Môn, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (7, 4, N'HoangHuy', N'F1E0F3F5A1D83C1E2498231CCBF15D13', N'HoangHuy@gmail.com', N'Huỳnh Hoàng Huy', N'0918575408', N'imgs/avatar/avatar7.jpg', 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (8, 4, N'TranTin', N'F1E0F3F5A1D83C1E2498231CCBF15D13', N'TranTin@gmail.com', N'Trần Hữu Tín', N'0934567892', NULL, 1, N'Cái Răng, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (9, 4, N'hoangvani', N'F1E0F3F5A1D83C1E2498231CCBF15D13', N'hoangvani@gmail.com', N'Hoàng Văn I', N'0934567893', NULL, 1, N'Thốt Nốt, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (10, 4, N'phamngock', N'F1E0F3F5A1D83C1E2498231CCBF15D13', N'phamngock@gmail.com', N'Phạm Ngọc K', N'0934567894', NULL, 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (11, 4, N'tranvanl', N'F1E0F3F5A1D83C1E2498231CCBF15D13', N'tranvanl@gmail.com', N'Trần Văn L', N'0934567895', NULL, 1, N'Bình Thủy, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (12, 2, N'ngominhm', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'ngominhm@gmail.com', N'Ngô Minh M', N'0945678901', NULL, 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (13, 2, N'dangthanhn', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'dangthanhn@gmail.com', N'Đặng Thanh N', N'0945678902', NULL, 1, N'Cái Răng, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (14, 2, N'nguyenvano', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'nguyenvano@gmail.com', N'Nguyễn Văn O', N'0945678903', NULL, 1, N'Thốt Nốt, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (15, 2, N'buithip', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'buithip@gmail.com', N'Bùi Thị P', N'0945678904', NULL, 1, N'Ô Môn, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (16, 2, N'hoangvanq', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'hoangvanq@gmail.com', N'Hoàng Văn Q', N'0945678905', NULL, 1, N'Bình Thủy, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (17, 2, N'nguyenthanhr', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'nguyenthanhr@gmail.com', N'Nguyễn Thành R', N'0945678906', NULL, 1, N'Cái Răng, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (18, 2, N'tranminhs', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'tranminhs@gmail.com', N'Trần Minh S', N'0945678907', NULL, 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (19, 2, N'lengoct', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'lengoct@gmail.com', N'Lê Ngọc T', N'0945678908', NULL, 1, N'Bình Thủy, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (20, 2, N'dovanu', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'dovanu@gmail.com', N'Đỗ Văn U', N'0945678909', NULL, 1, N'Ô Môn, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (21, 2, N'phamthiv', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'phamthiv@gmail.com', N'Phạm Thị V', N'0945678910', NULL, 1, N'Thốt Nốt, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (22, 2, N'buivanw', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'buivanw@gmail.com', N'Bùi Văn W', N'0945678911', NULL, 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (23, 2, N'ngothanhx', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'ngothanhx@gmail.com', N'Ngô Thanh X', N'0945678912', NULL, 1, N'Cái Răng, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (24, 2, N'hoangvany', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'hoangvany@gmail.com', N'Hoàng Văn Y', N'0945678913', NULL, 1, N'Bình Thủy, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (25, 2, N'nguyenthiz', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'nguyenthiz@gmail.com', N'Nguyễn Thị Z', N'0945678914', NULL, 1, N'Ô Môn, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (26, 2, N'phamvanaa', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'phamvanaa@gmail.com', N'Phạm Văn AA', N'0945678915', NULL, 1, N'Ninh Kiều, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (27, 2, N'lethanhbb', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'lethanhbb@gmail.com', N'Lê Thành BB', N'0945678916', NULL, 1, N'Cái Răng, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (28, 2, N'nguyenngoccc', N'A421E6B1F4EF36EE345DB8DB566D6B02', N'nguyenngoccc@gmail.com', N'Nguyễn Ngọc CC', N'0945678917', NULL, 1, N'Bình Thủy, Cần Thơ')
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (29, 2, N'huyhhce181847@fpt.edu.vn', N'google_oauth', N'huyhhce181847@fpt.edu.vn', N'Huynh Hoang Huy (K18 CT)', NULL, N'https://lh3.googleusercontent.com/a/ACg8ocILFBkD_rliRQVIfe88W1_WEYYhEDDEEZhp7wP8GG5TfagIlA=s96-c', 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (30, 2, N'huynhhoanghuy.25@gmail.com', N'google_oauth', N'huynhhoanghuy.25@gmail.com', N'Huỳnh Hoàng Huy', NULL, N'https://lh3.googleusercontent.com/a/ACg8ocKlKmdGKvphrsuflbgDjHtBE1XNn4yOs9dzWW88iNGEOIp4HTIw=s96-c', 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (31, 2, N'admin', N'41497b47723be730bb7b4a1b10b40ced', N'hungptce180265@fpt.edu.vn', N'HungPT', N'0123455677', NULL, 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (32, 2, N'hungvinh229@gmail.com', N'google_oauth', N'hungvinh229@gmail.com', N'Phan Thành Hưng', NULL, N'https://lh3.googleusercontent.com/a/ACg8ocIQBWGeYEzZk6CBbEoANe66eokoNwfSUbMeKmvsDWAxCioP1Mam=s96-c', 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (33, 2, N'hungphan', N'ed058cb75d9b7915e362157deaddc72d', N'hungvinh220904@gmail.com', N'HungPTCE', N'0987654321', NULL, 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (34, 2, N'hungPT', N'41497b47723be730bb7b4a1b10b40ced', N'hungvinh22092004@gmail.com', N'Phan Thanh Hung', N'0772967041', NULL, 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (35, 2, N'user5', N'ed058cb75d9b7915e362157deaddc72d', N'fuctchessclub@gmail.com', N'HungPT', N'0772967049', NULL, 1, NULL)
INSERT [dbo].[Users] ([UserID], [RoleID], [Username], [Password], [Email], [FullName], [Phone], [Avatar], [UserStatus], [Address]) VALUES (36, 2, N'hungpt123', N'f4ad231214cb99a985dff0f056a36242', N'quy98917@gmail.com', N'Quy', N'0223214324', NULL, 0, N'31/123 Huynh Phan Ho')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4182A48A7]    Script Date: 3/27/2025 12:30:00 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4EF8ED41D]    Script Date: 3/27/2025 12:30:00 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534293886EB]    Script Date: 3/27/2025 12:30:00 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534DBEAF118]    Script Date: 3/27/2025 12:30:00 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdoptionHistory] ADD  DEFAULT (getdate()) FOR [AdoptionDate]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT (getdate()) FOR [BookingDate]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT ('Pending') FOR [AppointmentStatus]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[MedicalRecords] ADD  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [OrderStatus]
GO
ALTER TABLE [dbo].[Payment] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[Payment] ADD  DEFAULT ('Completed') FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[Pets] ADD  DEFAULT ('Available') FOR [AdoptionStatus]
GO
ALTER TABLE [dbo].[ProductComment] ADD  DEFAULT (getdate()) FOR [Date_Comment]
GO
ALTER TABLE [dbo].[ProductComment] ADD  DEFAULT ((1)) FOR [ProductCommentStatus]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [ProductStatus]
GO
ALTER TABLE [dbo].[Services] ADD  DEFAULT ((1)) FOR [ServiceStatus]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [UserStatus]
GO
ALTER TABLE [dbo].[AdoptionHistory]  WITH CHECK ADD  CONSTRAINT [FK_Adoption_Pet] FOREIGN KEY([PetID])
REFERENCES [dbo].[Pets] ([PetID])
GO
ALTER TABLE [dbo].[AdoptionHistory] CHECK CONSTRAINT [FK_Adoption_Pet]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointment_Customer]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointment_Doctor]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Pet] FOREIGN KEY([PetID])
REFERENCES [dbo].[Pets] ([PetID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointment_Pet]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Service] FOREIGN KEY([ServiceID])
REFERENCES [dbo].[Services] ([ServiceID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointment_Service]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointment_Staff]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_User]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_Medical_Appointment] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointments] ([AppointmentID])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_Medical_Appointment]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_Medical_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_Medical_Doctor]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_Medical_Pet] FOREIGN KEY([PetID])
REFERENCES [dbo].[Pets] ([PetID])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_Medical_Pet]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Appointment] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointments] ([AppointmentID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Appointment]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Order]
GO
ALTER TABLE [dbo].[Pets]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[PetCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[Pets] CHECK CONSTRAINT [FK_Pet_Category]
GO
ALTER TABLE [dbo].[Pets]  WITH CHECK ADD  CONSTRAINT [FK_Pet_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Pets] CHECK CONSTRAINT [FK_Pet_User]
GO
ALTER TABLE [dbo].[ProductComment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductComment] CHECK CONSTRAINT [FK_Comment_Product]
GO
ALTER TABLE [dbo].[ProductComment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ProductComment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Services]  WITH CHECK ADD  CONSTRAINT [FK_Service_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ServiceCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[Services] CHECK CONSTRAINT [FK_Service_Category]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[ProductComment]  WITH CHECK ADD CHECK  (([Star]>=(1) AND [Star]<=(5)))
GO
ALTER TABLE [dbo].[ProductComment]  WITH CHECK ADD CHECK  (([Star]>=(1) AND [Star]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [PawHouseProjectHasData] SET  READ_WRITE 
GO
