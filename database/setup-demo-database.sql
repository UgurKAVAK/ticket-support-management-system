/* ============================================================
   Ticket Support Management System - Demo Database Setup
   Creates:
   - TicketSystemAuthDemoDb
   - TicketSystemDemoDb

   Demo Login:
   Username: demo
   Password: Demo123!
   Email: demo@ticketsystem.local
   ============================================================ */

USE master;
GO

IF DB_ID('TicketSystemAuthDemoDb') IS NOT NULL
BEGIN
    ALTER DATABASE TicketSystemAuthDemoDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TicketSystemAuthDemoDb;
END
GO

IF DB_ID('TicketSystemDemoDb') IS NOT NULL
BEGIN
    ALTER DATABASE TicketSystemDemoDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TicketSystemDemoDb;
END
GO

CREATE DATABASE TicketSystemAuthDemoDb;
GO

CREATE DATABASE TicketSystemDemoDb;
GO

/* ============================================================
   AUTH DATABASE
   ============================================================ */

USE TicketSystemAuthDemoDb;
GO

CREATE TABLE [dbo].[AspNetRoles](
    [Id] [nvarchar](450) NOT NULL,
    [Name] [nvarchar](256) NULL,
    [NormalizedName] [nvarchar](256) NULL,
    [ConcurrencyStamp] [nvarchar](max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[AspNetUsers](
    [Id] [nvarchar](450) NOT NULL,
    [UserName] [nvarchar](256) NULL,
    [NormalizedUserName] [nvarchar](256) NULL,
    [Email] [nvarchar](256) NULL,
    [NormalizedEmail] [nvarchar](256) NULL,
    [EmailConfirmed] [bit] NOT NULL,
    [PasswordHash] [nvarchar](max) NULL,
    [SecurityStamp] [nvarchar](max) NULL,
    [ConcurrencyStamp] [nvarchar](max) NULL,
    [PhoneNumber] [nvarchar](max) NULL,
    [PhoneNumberConfirmed] [bit] NOT NULL,
    [TwoFactorEnabled] [bit] NOT NULL,
    [LockoutEnd] [datetimeoffset](7) NULL,
    [LockoutEnabled] [bit] NOT NULL,
    [AccessFailedCount] [int] NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[AspNetUserRoles](
    [UserId] [nvarchar](450) NOT NULL,
    [RoleId] [nvarchar](450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC)
);
GO

CREATE TABLE [dbo].[AspNetRoleClaims](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [RoleId] [nvarchar](450) NOT NULL,
    [ClaimType] [nvarchar](max) NULL,
    [ClaimValue] [nvarchar](max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[AspNetUserClaims](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [UserId] [nvarchar](450) NOT NULL,
    [ClaimType] [nvarchar](max) NULL,
    [ClaimValue] [nvarchar](max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[AspNetUserLogins](
    [LoginProvider] [nvarchar](450) NOT NULL,
    [ProviderKey] [nvarchar](450) NOT NULL,
    [ProviderDisplayName] [nvarchar](max) NULL,
    [UserId] [nvarchar](450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC)
);
GO

CREATE TABLE [dbo].[AspNetUserTokens](
    [UserId] [nvarchar](450) NOT NULL,
    [LoginProvider] [nvarchar](450) NOT NULL,
    [Name] [nvarchar](450) NOT NULL,
    [Value] [nvarchar](max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED ([UserId] ASC, [LoginProvider] ASC, [Name] ASC)
);
GO

CREATE TABLE [dbo].[UserRefreshTokens](
    [UserId] [nvarchar](450) NOT NULL,
    [Code] [nvarchar](200) NOT NULL,
    [Expiration] [datetime2](7) NOT NULL,
    CONSTRAINT [PK_UserRefreshTokens] PRIMARY KEY CLUSTERED ([UserId] ASC)
);
GO

ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
FOREIGN KEY([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[AspNetRoleClaims] ADD CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
FOREIGN KEY([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;
GO

DECLARE @DemoUserId nvarchar(450) = N'11111111-1111-1111-1111-111111111111';
DECLARE @AdminRoleId nvarchar(450) = N'22222222-2222-2222-2222-222222222222';

INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES (@AdminRoleId, N'Admin', N'ADMIN', NEWID());

INSERT INTO AspNetUsers
(Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp,
 PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount)
VALUES
(
    @DemoUserId,
    N'demo',
    N'DEMO',
    N'demo@ticketsystem.local',
    N'DEMO@TICKETSYSTEM.LOCAL',
    1,
    N'AQAAAAIAAYagAAAAEA5RjtpLsvCmwJcQEYxSZc1c0PzO6woFtstCANQXau1gMdEJm5Mhs4MgrAK5c+9ENg==',
    REPLACE(CONVERT(nvarchar(36), NEWID()), '-', ''),
    CONVERT(nvarchar(36), NEWID()),
    NULL,
    0,
    0,
    NULL,
    1,
    0
);

INSERT INTO AspNetUserRoles (UserId, RoleId)
VALUES (@DemoUserId, @AdminRoleId);
GO

/* ============================================================
   TICKET DATABASE
   ============================================================ */

USE TicketSystemDemoDb;
GO

CREATE TABLE [dbo].[SysUser](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [nvarchar](200) NOT NULL,
    [LastName] [nvarchar](200) NOT NULL,
    [Email] [nvarchar](150) NOT NULL,
    [PhoneNumber] [nvarchar](50) NOT NULL,
    [Username] [nvarchar](200) NOT NULL,
    [Password] [nvarchar](200) NOT NULL,
    [IsActive] [bit] NOT NULL,
    [IsSupportAgent] [bit] NOT NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    CONSTRAINT [PK_SysUser] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[EmailThreads](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [ThreadKey] [nvarchar](400) NOT NULL,
    [NormalizedSubject] [nvarchar](500) NULL,
    [StarterMessageId] [nvarchar](300) NULL,
    [StarterDateUtc] [datetime2](7) NOT NULL,
    [LastMessageDateUtc] [datetime2](7) NOT NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    CONSTRAINT [PK_EmailThreads] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[Ticket](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](200) NOT NULL,
    [CompanyName] [nvarchar](200) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Description2] [nvarchar](max) NULL,
    [Status] [int] NOT NULL,
    [OpenedByUserId] [int] NOT NULL,
    [AssignedToUserId] [int] NULL,
    [IsFavorite] [bit] NOT NULL,
    [EmailThreadId] [int] NULL,
    [RequesterEmail] [nvarchar](300) NULL,
    [RequesterName] [nvarchar](300) NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    [LockedByUserId] [int] NULL,
    [LockedAtUtc] [datetime2](7) NULL,
    [LastViewedByUserId] [int] NULL,
    [LastViewedAtUtc] [datetime2](7) NULL,
    [HasUnreadInbound] [bit] NOT NULL CONSTRAINT [DF_Ticket_HasUnreadInbound] DEFAULT ((0)),
    [LastInboundAtUtc] [datetime2](7) NULL,
    [FirstResponseAtUtc] [datetime2](7) NULL,
    [StartedAtUtc] [datetime2](7) NULL,
    [StartedByUserId] [int] NULL,
    [ResolvedAtUtc] [datetime2](7) NULL,
    [ResolvedByUserId] [int] NULL,
    CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[TicketActivities](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [TicketId] [int] NOT NULL,
    [Type] [int] NOT NULL,
    [Message] [nvarchar](max) NOT NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    CONSTRAINT [PK_TicketActivities] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[TicketEmailMessages](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [MessageId] [nvarchar](300) NULL,
    [UniqueKey] [nvarchar](500) NOT NULL,
    [FromAddress] [nvarchar](300) NOT NULL,
    [Subject] [nvarchar](500) NOT NULL,
    [SubjectNormalized] [nvarchar](500) NULL,
    [ReceivedAtUtc] [datetime2](7) NOT NULL CONSTRAINT [DF_TicketEmailMessages_ReceivedAtUtc] DEFAULT (sysutcdatetime()),
    [EmailThreadId] [int] NULL,
    [TicketId] [int] NULL,
    [InReplyTo] [nvarchar](300) NULL,
    [ReferencesRaw] [nvarchar](max) NULL,
    [ToRaw] [nvarchar](max) NULL,
    [CcRaw] [nvarchar](max) NULL,
    [BodyText] [nvarchar](max) NULL,
    [BodyHtml] [nvarchar](max) NULL,
    [ProcessedAtUtc] [datetime2](7) NULL,
    [ProcessingError] [nvarchar](1000) NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    [Direction] [int] NOT NULL CONSTRAINT [DF_TicketEmailMessages_Direction] DEFAULT ((0)),
    [IsSent] [bit] NULL,
    [SendError] [nvarchar](1000) NULL,
    [SentAtUtc] [datetime2](7) NULL,
    CONSTRAINT [PK_TicketEmailMessages] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[TicketTransferLogs](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [TicketId] [int] NOT NULL,
    [FromUserId] [int] NOT NULL,
    [ToUserId] [int] NOT NULL,
    [WorkSummary] [nvarchar](max) NOT NULL,
    [ReasonType] [nvarchar](max) NOT NULL,
    [ReasonNote] [nvarchar](max) NOT NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    CONSTRAINT [PK_TicketTransferLogs] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[CalendarEvents](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](200) NOT NULL,
    [Description] [nvarchar](2000) NULL,
    [EventType] [int] NOT NULL,
    [StartDateUtc] [datetime2](7) NOT NULL,
    [EndDateUtc] [datetime2](7) NOT NULL,
    [IsAllDay] [bit] NOT NULL,
    [CompanyName] [nvarchar](200) NULL,
    [Location] [nvarchar](300) NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    CONSTRAINT [PK_CalendarEvents] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [dbo].[CalendarEventParticipants](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [CalendarEventId] [int] NOT NULL,
    [UserId] [int] NOT NULL,
    [CreatedDate] [datetime2](7) NOT NULL,
    [CreatedBy] [int] NULL,
    [ModifiedDate] [datetime2](7) NULL,
    [ModifiedBy] [int] NULL,
    CONSTRAINT [PK_CalendarEventParticipants] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [FK_Ticket_EmailThreads_EmailThreadId]
FOREIGN KEY([EmailThreadId]) REFERENCES [dbo].[EmailThreads] ([Id]);
GO

ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [FK_Ticket_SysUser_AssignedToUserId]
FOREIGN KEY([AssignedToUserId]) REFERENCES [dbo].[SysUser] ([Id]) ON DELETE SET NULL;
GO

ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [FK_Ticket_SysUser_OpenedByUserId]
FOREIGN KEY([OpenedByUserId]) REFERENCES [dbo].[SysUser] ([Id]);
GO

ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [FK_Tickets_StartedByUser_SysUser]
FOREIGN KEY([StartedByUserId]) REFERENCES [dbo].[SysUser] ([Id]);
GO

ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [FK_Tickets_ResolvedByUser_SysUser]
FOREIGN KEY([ResolvedByUserId]) REFERENCES [dbo].[SysUser] ([Id]);
GO

ALTER TABLE [dbo].[TicketActivities] ADD CONSTRAINT [FK_TicketActivities_Ticket_TicketId]
FOREIGN KEY([TicketId]) REFERENCES [dbo].[Ticket] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[TicketEmailMessages] ADD CONSTRAINT [FK_TicketEmailMessages_EmailThreads_EmailThreadId]
FOREIGN KEY([EmailThreadId]) REFERENCES [dbo].[EmailThreads] ([Id]);
GO

ALTER TABLE [dbo].[TicketTransferLogs] ADD CONSTRAINT [FK_TicketTransferLogs_Ticket_TicketId]
FOREIGN KEY([TicketId]) REFERENCES [dbo].[Ticket] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[TicketTransferLogs] ADD CONSTRAINT [FK_TicketTransferLogs_FromUsers]
FOREIGN KEY([FromUserId]) REFERENCES [dbo].[SysUser] ([Id]);
GO

ALTER TABLE [dbo].[TicketTransferLogs] ADD CONSTRAINT [FK_TicketTransferLogs_ToUsers]
FOREIGN KEY([ToUserId]) REFERENCES [dbo].[SysUser] ([Id]);
GO

ALTER TABLE [dbo].[CalendarEventParticipants] ADD CONSTRAINT [FK_CalendarEventParticipants_CalendarEvents_CalendarEventId]
FOREIGN KEY([CalendarEventId]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CalendarEventParticipants] ADD CONSTRAINT [FK_CalendarEventParticipants_SysUser_UserId]
FOREIGN KEY([UserId]) REFERENCES [dbo].[SysUser] ([Id]);
GO

/* ============================================================
   DEMO DATA
   ============================================================ */

INSERT INTO SysUser
(FirstName, LastName, Email, PhoneNumber, Username, Password, IsActive, IsSupportAgent, CreatedDate, CreatedBy)
VALUES
('Demo', 'User', 'demo@ticketsystem.local', '5550000001', 'demo', 'Demo123!', 1, 1, DATEADD(day,-30,GETUTCDATE()), NULL),
('Support', 'Agent', 'support.agent@ticketsystem.local', '5550000002', 'support.agent', 'Demo123!', 1, 1, DATEADD(day,-30,GETUTCDATE()), NULL),
('Service', 'Desk', 'service.desk@ticketsystem.local', '5550000003', 'service.desk', 'Demo123!', 1, 1, DATEADD(day,-30,GETUTCDATE()), NULL);

INSERT INTO EmailThreads
(ThreadKey, NormalizedSubject, StarterMessageId, StarterDateUtc, LastMessageDateUtc, CreatedDate, CreatedBy)
VALUES
('thr:demo-001', 'WAREHOUSE TRANSFER ISSUE', '<demo-001@ticketsystem.local>', DATEADD(day,-12,GETUTCDATE()), DATEADD(day,-11,GETUTCDATE()), DATEADD(day,-12,GETUTCDATE()), NULL),
('thr:demo-002', 'INVOICE EXPORT TIMEOUT', '<demo-002@ticketsystem.local>', DATEADD(day,-8,GETUTCDATE()), DATEADD(day,-7,GETUTCDATE()), DATEADD(day,-8,GETUTCDATE()), NULL),
('thr:demo-003', 'BARCODE PRINTING PROBLEM', '<demo-003@ticketsystem.local>', DATEADD(day,-5,GETUTCDATE()), DATEADD(hour,-8,GETUTCDATE()), DATEADD(day,-5,GETUTCDATE()), NULL),
('thr:demo-004', 'STOCK SYNC DELAY', '<demo-004@ticketsystem.local>', DATEADD(day,-2,GETUTCDATE()), DATEADD(hour,-3,GETUTCDATE()), DATEADD(day,-2,GETUTCDATE()), NULL);

INSERT INTO Ticket
(Title, CompanyName, Description, Description2, Status, OpenedByUserId, AssignedToUserId, IsFavorite, EmailThreadId,
 RequesterEmail, RequesterName, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy,
 LockedByUserId, LockedAtUtc, LastViewedByUserId, LastViewedAtUtc,
 HasUnreadInbound, LastInboundAtUtc, FirstResponseAtUtc, StartedAtUtc, StartedByUserId, ResolvedAtUtc, ResolvedByUserId)
VALUES
('Warehouse transfer issue for picking batch', 'Northwind Logistics',
'Products assigned to a warehouse transfer batch are not appearing on the outbound picking screen. The issue started after the nightly synchronization process.',
'Customer shared sample transfer number and warehouse code.', 3, 1, 1, 1, 1,
'warehouse.ops@northwind-demo.com', 'Warehouse Operations', DATEADD(day,-12,GETUTCDATE()), 1, DATEADD(day,-10,GETUTCDATE()), 1,
NULL, NULL, 1, DATEADD(hour,-4,GETUTCDATE()), 1, DATEADD(hour,-3,GETUTCDATE()), DATEADD(day,-11,GETUTCDATE()), DATEADD(day,-12,GETUTCDATE()), 1, NULL, NULL),

('Invoice export timeout on monthly report', 'BlueOcean Retail',
'Finance users receive a timeout error while exporting monthly invoice reports. The report works for short date ranges but fails for monthly periods.',
NULL, 2, 1, 2, 0, 2,
'finance@blueocean-demo.com', 'Finance Team', DATEADD(day,-8,GETUTCDATE()), 1, DATEADD(day,-7,GETUTCDATE()), 2,
NULL, NULL, 2, DATEADD(day,-7,GETUTCDATE()), 0, DATEADD(day,-7,GETUTCDATE()), DATEADD(day,-8,GETUTCDATE()), DATEADD(day,-8,GETUTCDATE()), 2, NULL, NULL),

('Barcode labels are not printed after order confirmation', 'Global Parts Supply',
'Barcode labels are not generated after confirming customer orders. Warehouse users have to manually retry the operation.',
'Printer queue logs should be reviewed.', 5, 1, 3, 1, 3,
'it.support@globalparts-demo.com', 'IT Support', DATEADD(day,-5,GETUTCDATE()), 1, DATEADD(hour,-8,GETUTCDATE()), 3,
NULL, NULL, 3, DATEADD(hour,-10,GETUTCDATE()), 1, DATEADD(hour,-8,GETUTCDATE()), DATEADD(day,-5,GETUTCDATE()), DATEADD(day,-5,GETUTCDATE()), 3, NULL, NULL),

('Stock synchronization delay between ERP and WMS', 'Vertex Distribution',
'Stock quantity changes in ERP are reflected in WMS with a delay. Customer reports mismatched stock levels during order preparation.',
NULL, 1, 1, 1, 0, 4,
'operations@vertex-demo.com', 'Operations Team', DATEADD(day,-2,GETUTCDATE()), 1, DATEADD(hour,-3,GETUTCDATE()), NULL,
NULL, NULL, NULL, NULL, 1, DATEADD(hour,-3,GETUTCDATE()), NULL, NULL, NULL, NULL, NULL),

('Customer account balance report shows incorrect totals', 'Demo Retail Group',
'Account balance report returns inconsistent totals when branch filter is selected together with a custom date range.',
NULL, 4, 1, 2, 0, NULL,
'reporting@demoretail.local', 'Reporting User', DATEADD(day,-15,GETUTCDATE()), 1, DATEADD(day,-13,GETUTCDATE()), 2,
NULL, NULL, 2, DATEADD(day,-13,GETUTCDATE()), 0, DATEADD(day,-14,GETUTCDATE()), DATEADD(day,-15,GETUTCDATE()), DATEADD(day,-15,GETUTCDATE()), 2, NULL, NULL),

('Email notification was not delivered to customer', 'Northwind Logistics',
'Customer did not receive notification emails after ticket status changes. SMTP logs should be checked.',
NULL, 6, 1, 1, 0, NULL,
'admin@northwind-demo.com', 'Admin User', DATEADD(day,-20,GETUTCDATE()), 1, DATEADD(day,-18,GETUTCDATE()), 1,
NULL, NULL, 1, DATEADD(day,-18,GETUTCDATE()), 0, DATEADD(day,-19,GETUTCDATE()), DATEADD(day,-20,GETUTCDATE()), DATEADD(day,-20,GETUTCDATE()), 1, DATEADD(day,-18,GETUTCDATE()), 1),

('Mobile session expires unexpectedly', 'BlueOcean Retail',
'Users are redirected to the login screen after a short period of inactivity. Token expiration settings need to be reviewed.',
NULL, 6, 1, 2, 0, NULL,
'mobile@blueocean-demo.com', 'Mobile Team', DATEADD(day,-18,GETUTCDATE()), 1, DATEADD(day,-15,GETUTCDATE()), 2,
NULL, NULL, 2, DATEADD(day,-15,GETUTCDATE()), 0, DATEADD(day,-17,GETUTCDATE()), DATEADD(day,-18,GETUTCDATE()), DATEADD(day,-18,GETUTCDATE()), 2, DATEADD(day,-15,GETUTCDATE()), 2),

('New warehouse location is missing from transfer screen', 'Global Parts Supply',
'A new warehouse location was created in ERP but it is not listed in the transfer screen.',
NULL, 2, 1, 3, 0, NULL,
'warehouse@globalparts-demo.com', 'Warehouse User', DATEADD(day,-1,GETUTCDATE()), 1, DATEADD(hour,-6,GETUTCDATE()), 3,
NULL, NULL, 3, DATEADD(hour,-6,GETUTCDATE()), 0, DATEADD(hour,-8,GETUTCDATE()), DATEADD(day,-1,GETUTCDATE()), DATEADD(day,-1,GETUTCDATE()), 3, NULL, NULL);

INSERT INTO TicketActivities
(TicketId, Type, Message, CreatedDate, CreatedBy)
VALUES
(1, 1, 'Ticket created via incoming email.', DATEADD(day,-12,GETUTCDATE()), 1),
(1, 12, 'Automatic acknowledgement email sent to requester.', DATEADD(day,-12,GETUTCDATE()), NULL),
(1, 2, 'Status changed from "Request Received" to "Waiting Customer".', DATEADD(day,-11,GETUTCDATE()), 1),
(1, 11, 'Customer replied with sample transfer number.', DATEADD(hour,-3,GETUTCDATE()), NULL),

(2, 1, 'Ticket created via incoming email.', DATEADD(day,-8,GETUTCDATE()), 1),
(2, 2, 'Ticket moved to processing.', DATEADD(day,-8,GETUTCDATE()), 2),
(2, 12, 'Support response sent to customer.', DATEADD(day,-7,GETUTCDATE()), 2),

(3, 1, 'Ticket created via incoming email.', DATEADD(day,-5,GETUTCDATE()), 1),
(3, 10, 'Assigned support agent changed: Demo User → Service Desk. Reason: specialist support required.', DATEADD(day,-4,GETUTCDATE()), 1),
(3, 2, 'Status changed to "Waiting Internal Team".', DATEADD(day,-4,GETUTCDATE()), 3),
(3, 11, 'Customer replied with printer queue logs.', DATEADD(hour,-8,GETUTCDATE()), NULL),

(4, 1, 'Ticket created via incoming email.', DATEADD(day,-2,GETUTCDATE()), 1),
(4, 11, 'New customer email reply received.', DATEADD(hour,-3,GETUTCDATE()), NULL),

(5, 1, 'Ticket created manually.', DATEADD(day,-15,GETUTCDATE()), 1),
(5, 2, 'Status changed to "Waiting External Vendor".', DATEADD(day,-13,GETUTCDATE()), 2),

(6, 1, 'Ticket created via incoming email.', DATEADD(day,-20,GETUTCDATE()), 1),
(6, 12, 'Support response sent to customer.', DATEADD(day,-19,GETUTCDATE()), 1),
(6, 2, 'Status changed to "Resolved".', DATEADD(day,-18,GETUTCDATE()), 1),

(7, 1, 'Ticket created via incoming email.', DATEADD(day,-18,GETUTCDATE()), 1),
(7, 2, 'Status changed to "Resolved".', DATEADD(day,-15,GETUTCDATE()), 2),

(8, 1, 'Ticket created manually.', DATEADD(day,-1,GETUTCDATE()), 1),
(8, 2, 'Ticket moved to processing.', DATEADD(hour,-6,GETUTCDATE()), 3);

INSERT INTO TicketTransferLogs
(TicketId, FromUserId, ToUserId, WorkSummary, ReasonType, ReasonNote, CreatedDate, CreatedBy)
VALUES
(3, 1, 3, 'Initial barcode issue analysis completed. Printer queue and order confirmation logs were reviewed.', 'SpecialistSupport', 'Transferred to service desk for deeper printer integration analysis.', DATEADD(day,-4,GETUTCDATE()), 1),
(5, 1, 2, 'Report filters reproduced with branch and custom date range parameters.', 'WorkloadTransfer', 'Transferred to support agent responsible for reporting module follow-up.', DATEADD(day,-13,GETUTCDATE()), 1);

INSERT INTO TicketEmailMessages
(MessageId, UniqueKey, FromAddress, Subject, SubjectNormalized, ReceivedAtUtc, EmailThreadId, TicketId,
 InReplyTo, ReferencesRaw, ToRaw, CcRaw, BodyText, BodyHtml, ProcessedAtUtc, CreatedDate, Direction, IsSent, SentAtUtc)
VALUES
('<demo-001@ticketsystem.local>', 'msgid:demo-001', 'warehouse.ops@northwind-demo.com',
 'Warehouse transfer issue for picking batch', 'WAREHOUSE TRANSFER ISSUE', DATEADD(day,-12,GETUTCDATE()), 1, 1,
 NULL, NULL, 'support@ticketsystem.local', NULL,
 'Products assigned to transfer batch are not appearing on the outbound picking screen.',
 '<p>Products assigned to transfer batch are not appearing on the outbound picking screen.</p>',
 DATEADD(day,-12,GETUTCDATE()), DATEADD(day,-12,GETUTCDATE()), 1, NULL, NULL),

('<demo-out-001@ticketsystem.local>', 'out:ack:1', 'support@ticketsystem.local',
 'Re: Warehouse transfer issue for picking batch', 'WAREHOUSE TRANSFER ISSUE', DATEADD(day,-12,GETUTCDATE()), 1, 1,
 '<demo-001@ticketsystem.local>', '<demo-001@ticketsystem.local>', 'warehouse.ops@northwind-demo.com', NULL,
 NULL,
 '<p>Your support request has been received and is currently under review.</p>',
 DATEADD(day,-12,GETUTCDATE()), DATEADD(day,-12,GETUTCDATE()), 2, 1, DATEADD(day,-12,GETUTCDATE())),

('<demo-003@ticketsystem.local>', 'msgid:demo-003', 'it.support@globalparts-demo.com',
 'Barcode printing problem', 'BARCODE PRINTING PROBLEM', DATEADD(day,-5,GETUTCDATE()), 3, 3,
 NULL, NULL, 'support@ticketsystem.local', NULL,
 'Barcode labels are not generated after confirming customer orders.',
 '<p>Barcode labels are not generated after confirming customer orders.</p>',
 DATEADD(day,-5,GETUTCDATE()), DATEADD(day,-5,GETUTCDATE()), 1, NULL, NULL),

('<demo-004@ticketsystem.local>', 'msgid:demo-004', 'operations@vertex-demo.com',
 'Stock synchronization delay between ERP and WMS', 'STOCK SYNC DELAY', DATEADD(day,-2,GETUTCDATE()), 4, 4,
 NULL, NULL, 'support@ticketsystem.local', NULL,
 'Stock quantity changes in ERP are reflected in WMS with delay.',
 '<p>Stock quantity changes in ERP are reflected in WMS with delay.</p>',
 DATEADD(day,-2,GETUTCDATE()), DATEADD(day,-2,GETUTCDATE()), 1, NULL, NULL);
GO

PRINT 'Demo database setup completed successfully.';
GO