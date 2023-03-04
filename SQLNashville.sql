SELECT *
FROM PortfolioProject.dbo.NashVilleHousings


---Standardized Date Format

SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM PortfolioProject.dbo.NashVilleHousings

UPDATE NashVilleHousings
SET SaleDate = CONVERT(Date,Saledate)

ALTER TABLE Adventure
ADD SaleDateConverted Date;

UPDATE NashVilleHousings
SET SaleDateConverted = CONVERT(Date,Saledate)
----------------------------------------------------------------------------------

--Populate Property Address Data

SELECT *
FROM PortfolioProject.dbo.NashVilleHousings
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,
ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashVilleHousings a
JOIN PortfolioProject.dbo.NashVilleHousings b
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)  
FROM PortfolioProject.dbo.NashVilleHousings a
JOIN PortfolioProject.dbo.NashVilleHousings b
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

------------------------------------------------------------------------------

--Breaking out Address into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM PortfolioProject.dbo.NashVilleHousings
--WHERE PropertyAddress IS NULL
--ORDER BY ParcelID

SELECT 
SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS Address 

FROM PortfolioProject.dbo.NashVilleHousings

ALTER TABLE NashVilleHousings
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashVilleHousings
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) 

ALTER TABLE NashVilleHousings
ADD PropertySplitCity Nvarchar(255);

UPDATE NashVilleHousings
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

SELECT *
FROM PortfolioProject.dbo.NashVilleHousings 

--2nd way to split addresses

SELECT OwnerAddress
FROM PortfolioProject.dbo.NashVilleHousings

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
FROM PortfolioProject.dbo.NashVilleHousings

ALTER TABLE NashVilleHousings
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashVilleHousings
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashVilleHousings
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashVilleHousings
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashVilleHousings
ADD OwnerSplitState = Nvarchar(255);

UPDATE NashVilleHousings
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

SELECT *
FROM PortfolioProject.dbo.NashVilleHousings 



--------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashVilleHousings
GROUP BY SoldAsVacant
ORDER BY 2




SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
FROM PortfolioProject.dbo.NashVilleHousings

UPDATE NashVilleHousings
SET SoldAsVacant =CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END



-----------------------------------------------------------------------------------------

--Remove duplicates


WITH RowNumCTE AS(
SELECT *,
      ROW_NUMBER() OVER (
	  PARTITION BY ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   ORDER BY
				       UniqueID
					   )row_num
FROM PortfolioProject.dbo.NashVilleHousings
--ORDER BY ParcelID
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress


------------------------------------------------------------------------

--Delete Unused Coloumns

SELECT *
FROM PortfolioProject.dbo.NashVilleHousings

ALTER TABLE PortfolioProject.dbo.NashVilleHousings
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject.dbo.NashVilleHousings
DROP COLUMN SaleDate
