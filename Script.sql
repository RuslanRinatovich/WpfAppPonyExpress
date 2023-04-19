/*    ==Параметры сценариев==

    Версия исходного сервера : SQL Server 2017 (14.0.1000)
    Выпуск исходного ядра СУБД : Выпуск Microsoft SQL Server Express Edition
    Тип исходного ядра СУБД : Изолированный SQL Server

    Версия целевого сервера : SQL Server 2017
    Выпуск целевого ядра СУБД : Выпуск Microsoft SQL Server Standard Edition
    Тип целевого ядра СУБД : Изолированный SQL Server
*/
USE [master]
GO
/****** Object:  Database [PonyExpressDB]    Script Date: 17.04.2023 16:58:25 ******/
CREATE DATABASE [PonyExpressDB]

GO
USE [PonyExpressDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [PonyExpressDB]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Patronymic] [nvarchar](100) NULL,
	[Photo] [nvarchar](100) NULL,
	[PassportSeries] [nvarchar](4) NOT NULL,
	[PassportNum] [nvarchar](6) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatusID] [tinyint] NOT NULL,
	[OrderCreateDate] [datetime] NOT NULL,
	[OrderDeliveryDate] [datetime] NOT NULL,
	[OrderPickupPointID] [int] NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[GetCode] [int] NOT NULL,
	[RateId] [int] NULL,
	[Weight] [int] NULL,
 CONSTRAINT [PK__Order__C3905BAF67632E04] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Color] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickupPoint](
	[PickupPointId] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_PickupPoint] PRIMARY KEY CLUSTERED 
(
	[PickupPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rate]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rate](
	[RateId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[ZoneId] [int] NOT NULL,
	[Weight] [int] NOT NULL,
	[Price] [int] NOT NULL,
 CONSTRAINT [PK_Rate] PRIMARY KEY CLUSTERED 
(
	[RateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[DaysCount] [int] NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zone]    Script Date: 17.04.2023 16:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zone](
	[ZoneID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Zone] PRIMARY KEY CLUSTERED 
(
	[ZoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (0, N'fdf', N'fds', N'fds', N'Фото.jpeg', N'111', N'1111', NULL, N'34324', N'23321', N'y')
INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (1, N'Иванов', N'Иван', N'', NULL, N'111', N'1111', N'22222', N'уцуц', N'89656', N'x')
SET IDENTITY_INSERT [dbo].[Client] OFF
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (1, N'Готово к выдаче', N'#FFFFFF00')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (2, N' Отправление зарегистрировано', N'#FFDCDCDC')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (3, N'Посылка принята', N'#FFFF0000')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (4, N'В пути - Прибыла в промежуточный пункт', N'#FFF5DEB3')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[PickupPoint] ON 

INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (1, N'г. Казань, Ул. Павлюхина, 99')
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (2, N'г. Казань, Ул. Братьев Петряевых, д. 5, кор.4')
SET IDENTITY_INSERT [dbo].[PickupPoint] OFF
SET IDENTITY_INSERT [dbo].[Rate] ON 

INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (1, 1, 1, 1, 100)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (2, 1, 2, 1, 151)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (3, 2, 1, 1, 100)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (4, 2, 2, 1, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (5, 4, 6, 1, 7)
SET IDENTITY_INSERT [dbo].[Rate] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'manager')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'user')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (1, N'Доставка за день', N'1', 1)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (2, N'Доставка по времени', N'Доставка к определённому времени', 3)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (3, N'Экспресс', N'Экспресс за один день', 8)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (4, N'Стандарт', N'4', 4)
SET IDENTITY_INSERT [dbo].[Service] OFF
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'admin', N'1', 1)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'manager', N'1', 2)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'user', N'1', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'x', N'2', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'y', N'1', 3)
SET IDENTITY_INSERT [dbo].[Zone] ON 

INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (1, N'до 5 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (2, N'до 10 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (3, N'до 15 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (4, N'до 25 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (5, N'до 50 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (6, N'до 100 км')
SET IDENTITY_INSERT [dbo].[Zone] OFF
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_User] FOREIGN KEY([UserName])
REFERENCES [dbo].[User] ([UserName])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_User]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickupPoint] FOREIGN KEY([OrderPickupPointID])
REFERENCES [dbo].[PickupPoint] ([PickupPointId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PickupPoint]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Rate] FOREIGN KEY([RateId])
REFERENCES [dbo].[Rate] ([RateId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Rate]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserName])
REFERENCES [dbo].[User] ([UserName])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[Rate]  WITH CHECK ADD  CONSTRAINT [FK_Rate_Service] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Service] ([ServiceId])
GO
ALTER TABLE [dbo].[Rate] CHECK CONSTRAINT [FK_Rate_Service]
GO
ALTER TABLE [dbo].[Rate]  WITH CHECK ADD  CONSTRAINT [FK_Rate_Zone] FOREIGN KEY([ZoneId])
REFERENCES [dbo].[Zone] ([ZoneID])
GO
ALTER TABLE [dbo].[Rate] CHECK CONSTRAINT [FK_Rate_Zone]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [PonyExpressDB] SET  READ_WRITE 
GO
