-- Lấy ra tên của người duyệt báo có họ là "Nguyễn".

SELECT Full_Name AS Ten_Nguoi_Duyet_Ho_Nguyen
FROM EDITOR
WHERE Full_Name LIKE 'Nguyen%'
