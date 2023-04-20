USE [master]
GO
/****** Object:  Database [PonyExpressDB]    Script Date: 20.04.2023 0:03:09 ******/
CREATE DATABASE [PonyExpressDB]
 
GO
USE [PonyExpressDB]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[Rate]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[Service]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 20.04.2023 0:03:09 ******/
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
/****** Object:  Table [dbo].[Zone]    Script Date: 20.04.2023 0:03:09 ******/
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
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (1, 1, CAST(N'2023-04-19T00:00:00.000' AS DateTime), CAST(N'2023-04-23T00:00:00.000' AS DateTime), 1, N'x', 23, 2, 3)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (3, 3, CAST(N'2023-04-20T00:00:00.000' AS DateTime), CAST(N'2023-04-23T00:00:00.000' AS DateTime), 2, N'y', 4, 1, 5)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (1, N'Готово к выдаче', N'#FFFFFF00')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (2, N'Отправление зарегистрировано', N'#FFDCDCDC')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (3, N'Посылка принята', N'#FFFF0000')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (4, N'В пути - Прибыла в промежуточный пункт', N'#FFF5DEB3')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[PickupPoint] ON 

INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (1, N'г. Казань, Ул. Павлюхина, 99')
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (2, N'г. Казань, Ул. Братьев Петряевых, д. 5, кор.4')
SET IDENTITY_INSERT [dbo].[PickupPoint] OFF
GO
SET IDENTITY_INSERT [dbo].[Rate] ON 

INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (1, 1, 1, 10, 100)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (2, 1, 1, 20, 110)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (3, 1, 1, 30, 120)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (4, 1, 1, 40, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (5, 1, 1, 50, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (11, 1, 2, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (12, 1, 2, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (13, 1, 2, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (14, 1, 2, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (15, 1, 2, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (16, 1, 3, 10, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (17, 1, 3, 20, 160)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (18, 1, 3, 30, 170)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (19, 1, 3, 40, 180)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (20, 1, 3, 50, 190)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (21, 1, 4, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (22, 1, 4, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (23, 1, 4, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (24, 1, 4, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (25, 1, 4, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (26, 1, 5, 10, 125)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (27, 1, 5, 20, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (28, 1, 5, 30, 135)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (29, 1, 5, 40, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (30, 1, 5, 50, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (31, 2, 1, 10, 100)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (32, 2, 1, 20, 110)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (33, 2, 1, 30, 120)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (34, 2, 1, 40, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (35, 2, 1, 50, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (36, 2, 2, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (37, 2, 2, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (38, 2, 2, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (39, 2, 2, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (40, 2, 2, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (41, 2, 3, 10, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (42, 2, 3, 20, 160)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (43, 2, 3, 30, 170)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (44, 2, 3, 40, 180)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (45, 2, 3, 50, 190)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (46, 2, 4, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (47, 2, 4, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (48, 2, 4, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (49, 2, 4, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (50, 2, 4, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (51, 2, 5, 10, 125)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (52, 2, 5, 20, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (53, 2, 5, 30, 135)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (54, 2, 5, 40, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (55, 2, 5, 50, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (56, 3, 1, 10, 100)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (57, 3, 1, 20, 110)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (58, 3, 1, 30, 120)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (59, 3, 1, 40, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (60, 3, 1, 50, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (61, 3, 2, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (62, 3, 2, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (63, 3, 2, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (64, 3, 2, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (65, 3, 2, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (66, 3, 3, 10, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (67, 3, 3, 20, 160)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (68, 3, 3, 30, 170)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (69, 3, 3, 40, 180)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (70, 3, 3, 50, 190)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (71, 3, 4, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (72, 3, 4, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (73, 3, 4, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (74, 3, 4, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (75, 3, 4, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (76, 3, 5, 10, 125)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (77, 3, 5, 20, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (78, 3, 5, 30, 135)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (79, 3, 5, 40, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (80, 3, 5, 50, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (81, 4, 1, 10, 100)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (82, 4, 1, 20, 110)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (83, 4, 1, 30, 120)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (84, 4, 1, 40, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (85, 4, 1, 50, 140)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (86, 4, 2, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (87, 4, 2, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (88, 4, 2, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (89, 4, 2, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (90, 4, 2, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (91, 4, 3, 10, 150)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (92, 4, 3, 20, 160)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (93, 4, 3, 30, 170)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (94, 4, 3, 40, 180)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (95, 4, 3, 50, 190)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (96, 4, 4, 10, 200)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (97, 4, 4, 20, 210)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (98, 4, 4, 30, 220)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (99, 4, 4, 40, 230)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (100, 4, 4, 50, 240)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (101, 4, 5, 10, 125)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (102, 4, 5, 20, 130)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (103, 4, 5, 30, 135)
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (104, 4, 5, 40, 140)
GO
INSERT [dbo].[Rate] ([RateId], [ServiceId], [ZoneId], [Weight], [Price]) VALUES (105, 4, 5, 50, 150)
SET IDENTITY_INSERT [dbo].[Rate] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'manager')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'user')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (1, N'Доставка за день', N'1', 1)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (2, N'Доставка по времени', N'Доставка к определённому времени', 3)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (3, N'Экспресс', N'Экспресс за один день', 8)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (4, N'Стандарт', N'4', 4)
SET IDENTITY_INSERT [dbo].[Service] OFF
GO
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'admin', N'1', 1)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'manager', N'1', 2)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'user', N'1', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'x', N'2', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'y', N'1', 3)
GO
SET IDENTITY_INSERT [dbo].[Zone] ON 

INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (1, N'до 5 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (2, N'до 10 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (3, N'до 25 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (4, N'до 50 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (5, N'до 100 км')
SET IDENTITY_INSERT [dbo].[Zone] OFF
GO
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
