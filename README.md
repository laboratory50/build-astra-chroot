
# Краткая инструкция

## Подготовка

 1. aptitude install eatmydata pbuilder git-buildpackage reprepro
 2. Создаем GPG ключ изделия для подписи репозитория
 3. Создаем репозиторий, содержащий дистрибутив и диск разработчика
    Astra Linux Special Edition.

## Репозиторий вашего изделия

 1. mkdir -p myproduct/conf
 2. Параметры репозитория (myproduct/conf/distribution):

	Codename: myproduct
	Suite: stable
	Components: main contrib non-free
	Architectures: amd64 source
	Version: 1.0
	SignWith: <ключ подписи>
	Description: Супер-изделие типа звезды смерти, только лучше.

 3. myproduct/conf/options:

	ask-passphrase

 4. reprepro -b myproduct export
 5. reprepro -b myproduct createsymlinks


