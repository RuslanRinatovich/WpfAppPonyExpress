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
/****** Object:  Database [PonyExpressDB]    Script Date: 24.04.2023 17:02:49 ******/
CREATE DATABASE [PonyExpressDB]
GO
USE [PonyExpressDB]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 24.04.2023 17:02:49 ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 24.04.2023 17:02:49 ******/
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
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 24.04.2023 17:02:49 ******/
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
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 24.04.2023 17:02:49 ******/
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
/****** Object:  Table [dbo].[Rate]    Script Date: 24.04.2023 17:02:49 ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 24.04.2023 17:02:50 ******/
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
/****** Object:  Table [dbo].[Service]    Script Date: 24.04.2023 17:02:50 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 24.04.2023 17:02:50 ******/
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
/****** Object:  Table [dbo].[Zone]    Script Date: 24.04.2023 17:02:50 ******/
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

INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (4, N'Наварский', N'Платон', N'Константинович', N'1.jpg', N'9002', N'343524', N'Казань, ул.Пушкина , кв ', N'PlatonNavarskiy42@mail.ru', N'+7 (968) 439-71-20', N'Platon')
INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (5, N'Шарыпова', N'Лукерья', N'Григорьевна', N'2.jpg', N'2122', N'232443', N'Казань', N'LukeryaSharypova348', N'+7 (901) 203-60-41', N'Lukeriya')
INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (6, N'Дубинина', N'Лидия', N'Сергеевна', N'3.jpg', N'9909', N'435435', N'Зеленодольск', N'LidiyaDubinina108', N'+7 (952) 553-89-80', N'Lidiya')
INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (7, N'Каменских', N'Адриан', N'Константинович', N'4.jpg', N'2132', N'312321', N'Волжск', N'AdrianKamenskih468', N'+7 (942) 133-12-30', N'Adrian')
INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (8, N'Байков', N'Ян', N'Юрьевич', N'5.jpg', N'1322', N'343243', N'Казань', N'YanBaykov918@mail.ru', N'+7 (929) 551-05-76', N'Baikov')
INSERT [dbo].[Client] ([ClientId], [Surname], [Name], [Patronymic], [Photo], [PassportSeries], [PassportNum], [Address], [Email], [Phone], [UserName]) VALUES (9, N'Исмагилова', N'Лейсан', N'Маратовна', N'2.jpeg', N'9248', N'897878', N'Казань', N'leisanka@mail.ru', N'+7 (95) 589-45-12', N'Krasotka')
SET IDENTITY_INSERT [dbo].[Client] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (10, 3, CAST(N'2023-04-23T23:54:09.300' AS DateTime), CAST(N'2023-04-24T23:54:09.300' AS DateTime), 4, N'Lidiya', 954, 14, 34)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (11, 2, CAST(N'2023-04-23T23:58:30.243' AS DateTime), CAST(N'2023-04-26T23:58:30.243' AS DateTime), 1, N'Platon', 609, 41, 5)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (12, 3, CAST(N'2023-04-23T23:59:44.913' AS DateTime), CAST(N'2023-05-01T23:59:44.913' AS DateTime), 2, N'Lukeriya', 198, 67, 11)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (13, 1, CAST(N'2023-04-24T00:21:38.947' AS DateTime), CAST(N'2023-05-02T00:21:38.947' AS DateTime), 2, N'Adrian', 250, 69, 34)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (14, 1, CAST(N'2023-04-24T09:17:17.813' AS DateTime), CAST(N'2023-05-02T09:17:17.813' AS DateTime), 3, N'Baikov', 726, 68, 25)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (15, 1, CAST(N'2023-04-24T13:44:44.967' AS DateTime), CAST(N'2023-04-27T13:44:44.967' AS DateTime), 2, N'Krasotka', 437, 43, 25)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [OrderCreateDate], [OrderDeliveryDate], [OrderPickupPointID], [UserName], [GetCode], [RateId], [Weight]) VALUES (16, 1, CAST(N'2023-04-24T15:56:03.013' AS DateTime), CAST(N'2023-05-02T15:56:03.013' AS DateTime), 2, N'Krasotka', 681, 71, 10)
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (1, N'Создано', N'#FFFFFF00')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (2, N'Принято в работу', N'#FFFFE4E1')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (3, N'Передано в доставку', N'#FFADFF2F')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (4, N'Ожидает в пункте выдачи', N'#FFF5DEB3')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (5, N'Получено', N'#FF445454')
INSERT [dbo].[OrderStatus] ([Id], [Name], [Color]) VALUES (6, N'Отменено', N'#FFC0C0C0')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[PickupPoint] ON 

INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (1, N'г. Казань, Ул. Павлюхина, 99')
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (2, N'г. Казань, Ул. Братьев Петряевых, д. 5, кор.4')
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (3, N'г.Казань, Пушкина, 25')
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address]) VALUES (4, N'г.Зеленодольск, Ул. Ленина, 15')
SET IDENTITY_INSERT [dbo].[PickupPoint] OFF
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
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'manager')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'user')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (1, N'Доставка за день', N'1', 1)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (2, N'Доставка по времени', N'Доставка к определённому времени', 3)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (3, N'Экспресс', N'Экспресс за один день', 8)
INSERT [dbo].[Service] ([ServiceId], [Name], [Description], [DaysCount]) VALUES (4, N'Стандарт', N'Доставка в течение 4 рабочих дней', 4)
SET IDENTITY_INSERT [dbo].[Service] OFF
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'admin', N'1', 1)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'Adrian', N'1', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'Baikov', N'1', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'Krasotka', N'1', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'Lidiya', N'2', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'Lukeriya', N'1', 3)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'manager', N'1', 2)
INSERT [dbo].[User] ([UserName], [Password], [RoleId]) VALUES (N'Platon', N'1', 3)
SET IDENTITY_INSERT [dbo].[Zone] ON 

INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (1, N'до 5 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (2, N'до 10 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (3, N'до 25 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (4, N'до 50 км')
INSERT [dbo].[Zone] ([ZoneID], [Name]) VALUES (5, N'до 100 км')
SET IDENTITY_INSERT [dbo].[Zone] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Client]    Script Date: 24.04.2023 17:02:50 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Client] ON [dbo].[Client]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
