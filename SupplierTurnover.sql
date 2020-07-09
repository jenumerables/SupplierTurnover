USE EpicorERP
GO

select v.Name,v.Country, pd.PONUM as PONum,  ih.InvoiceNum, convert(varchar,rd.ReceiptDate,101) as ReceiptDate,  pd.POLine,pr.PORelNum, pr.XRelQty as OurQty, pd.DocUnitCost, pr.XRelQty * pd.DocUnitCost AS TotalExtended
from erp.APInvHed ih
join erp.PODetail pd on pd.PONUM = ih.REFPONum and pd.Company = ih.Company
join erp.PORel pr on pr.PONum = pd.PONUM and pr.Company = pd.Company and pr.POLine = pd.POLine
join erp.Vendor v on v.VendorNum = ih.VendorNum and v.Company = ih.Company
join erp.RcvDtl rd on rd.PONum = pr.PONum and rd.POLine = pr.POLine and rd.PORelNum = pr.PORelNum
where rd.ReceiptDate >= '2019-06-01' and rd.ReceiptDate <= '2020-05-31'
group by pd.PONUM, pd.POLine,pr.PORelNum, ih.InvoiceNum,v.Name,v.Country, rd.ReceiptDate, pr.PORelNum, pr.XRelQty, pd.DocUnitCost
order by v.name, pd.POLine, pr.PORelNum