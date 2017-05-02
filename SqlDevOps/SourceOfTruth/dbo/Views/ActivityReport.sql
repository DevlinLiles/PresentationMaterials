CREATE VIEW [dbo].[ActivityReport]
	AS 
Select rp.Name as ReportingPeriodName, aa.Name as AreaName, ad.Name as ActivityName, u.DisplayName as UserName, Count(a.Id) as ActivityCount, Sum(a.ReportedPoints) as TotalReported, Sum(a.AdjustedPoints) as TotalAdjusted, a.TenantId From Activities a
INNER JOIN ReportingPeriods rp on a.ReportingPeriodId = rp.Id
INNER JOIN ActivityAreas aa on a.AreaId = aa.Id
INNER JOIN ActivityDescriptions ad on a.DescriptionId = ad.Id
INNER JOIN Users as u on a.UserId = u.UserId
GROUP BY rp.Name, aa.Name, ad.Name, a.UserId, u.DisplayName, a.TenantId