v2
-- -----------------------------------------------------
-- Upload car_types info
-- -----------------------------------------------------
-- 11 categories
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Small and Compact", 108.00, 4.50);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Medium", 120.00, 5.00);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Large", 132.00, 5.50);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Sport and Convertible", 144.00, 6.00);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Luxury", 300.00, 12.50);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Hybrid and Electric", 150.00, 6.25);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Compact SUV", 150.00, 6.25);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Mid Size SUV", 168.00, 7.00);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Full Size SUV", 192.00, 8.00);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Passenger Van", 150.00, 6.25);
INSERT INTO car_types (type, price_per_day, price_per_hour)
VALUES ("Truck", 216.00, 9.00);
-- -----------------------------------------------------
-- Upload car info
-- -----------------------------------------------------
-- Small and Compact
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "MMR15489", "Mitsubishi", "Mirage", 2020, 36, 43);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "NRV56289", "Nissan", "Versa", 2020, 32, 40);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "UYZ45789", "Nissan", "Sentra", 2020, 29, 39);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "OPT78953", "Honda", "Civic", 2021, 31, 40);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "DFY45692", "Hyundai", "Elantra", 2020, 30, 40);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "RTY96325", "Toyota", "Corolla", 2021, 30, 38);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "OLT74125", "Chevrolet", "Cruze", 2021, 28, 42);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "WER83467", "Volkswagen", "Jetta", 2021, 30, 40);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "HFK64664", "Kia", "Forte", 2020, 31, 41);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "LOS64528", "Chevrolet", "Bolt", 2020, 28, 33);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "ZAQ35714", "Honda", "Fit", 2020, 33, 40);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "XSW12457", "Volkswagen", "GTI", 2020, 24, 32);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (1, "QXW15959", "Toyota", "Yaris", 2020, 32, 40);

-- Medium
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "WAQ38404", "Toyota", "Camry", 2021, 31, 36);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "ASD43467", "Honda", "Accord", 2020, 30, 38);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "DSQ55214", "Hyundai", "Sonata", 2021, 28, 38);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "ZAE45745", "Mazda", "Mazda6", 2020, 26, 35);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "EFR20104", "Ford", "Fusion", 2020, 21, 31);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "AFS65325", "Nisan", "Altima", 2020, 28, 39);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "SAY53268", "Subaru", "Legacy", 2020, 27, 35);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "LAQ23556", "Volkswagen", "Passat", 2020, 23, 34);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "ORV40608", "Chevrolet", "Malibu", 2021, 29, 36);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "WPL12215", "Buick", "Regal", 2020, 22, 32);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (2, "DSI51557", "Kia", "K5", 2021, 29, 38);

-- Large
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (3, "RKD92426", "Kia", "Cadenza", 2020, 20, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (3, "EOT66478", "Toyota", "Avalon", 2021, 22, 32);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (3, "LLQ23665", "Chevrolet", "Impala", 2020, 19, 28);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (3, "WPW62332", "Nissan", "Maxima", 2020, 20, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (3, "UCU53454", "Chyysler", "300", 2020, 19, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (3, "SND19375", "Dodge", "Charger", 2021, 19, 30);

-- Sport
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "RAR31313", "Ford", "Mustang", 2020, 21, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "TAZ22552", "Mazda", "MX-5 Miata", 2020, 26, 35);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "ATP29287", "Dodge", "Challenger", 2021, 19, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "PLT25825", "Chevrolet", "Camaro", 2021, 20, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "LOM36363", "Subaru", "BRZ", 2020, 24, 33);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "HJG92746", "Toyota", "86", 2020, 24, 32);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "GFT46863", "Fiat", "124 Spider", 2020, 25, 36);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (4, "DKL55575", "Nissan", "370Z", 2020, 19, 26);

-- Luxury
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "GSG22189", "Porsche", "Panamera", 2020, 27, 19);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "GFO77272", "Mercedes-Benz", "S-Class", 2020, 28, 19);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "UOT72412", "BMW", "7-Series", 2020, 29, 22);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "TYO57227", "Audi", "A8", 2021, 26, 17);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "PPE44272", "Genesis", "G70", 2021, 30, 22);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "TRT24427", "BMW", "2-Series", 2020, 32, 24);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "WTW70202", "Audi", "A5", 2021, 32, 24);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "KFL42323", "Audi", "A4", 2020, 35, 27);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "SJK54424", "Mercedes-Benz", "C-Class", 2020, 35, 24);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "SJU84227", "Lexus", "IS", 2020, 30, 21);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (5, "JSU48857", "Cadilac", "CT4", 2020, 34, 23);

-- Hybrid
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "DJD20408", "Toyota", "Camry Hybrid", 2020, 51, 53);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "HJH50510", "Honda", "Accord Hybrid", 2020, 48, 47);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "SKH30210", "Toyota", "Avalon Hybrid", 2021, 43, 44);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "ALS55755", "Honda", "Insight", 2021, 55, 49);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "LAO42055", "Ford", "Fusion Hybrid", 2020, 43, 41);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "DOO70170", "Kia", "Optima Hybrid", 2020, 40, 45);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "SPL30123", "Toyota", "Prius", 2021, 58, 53);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "PXZ69600", "MINI", "Electric Hardtop", 2021, 115, 100);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (6, "NSQ98001", "Nissa", "Leaf", 2020, 123, 99);

-- Compact SUV
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "PEM69702", "Honda", "CR-V", 2021, 28, 35);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "RTR56575", "Mazda", "CX-5", 2021, 25, 31);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "HMO90003", "Kia", "Sportage", 2021, 23, 30);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "BRT34156", "Ford", "Escape", 2020, 27, 33);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "CCJ25300", "Nissan", "Rogue", 2021, 26, 33);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "GRT66167", "Toyota", "RAV4", 2021, 29, 35);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "UML20052", "Volkswagen", "Tiguan", 2020, 22, 29);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (7, "CFT44744", "Subaru", "Froster", 2021, 26, 33);

-- Mid Size SUV
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "ZXY23232", "Hyundai", "Santa Fe", 2020, 22, 29);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "BZZ12015", "Kia", "Telluride", 2021, 20, 26);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "CCZ34300", "Hyundai", "Palisade", 2021, 19, 26);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "DPO05898", "Mazda", "CX-9", 2021, 22, 28);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "RVT33090", "Kia", "Sorento", 2020, 22, 29);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "XZL00934", "Honda", "Passport", 2021, 20, 25);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "LXZ10025", "Dodge", "Durango", 2021, 19, 26);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "WWE55700", "Buick", "Enclave", 2020, 18, 26);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (8, "LXY01890", "Honda", "Pilot", 2021, 20, 27);

-- Full Size SUV
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (9, "MWQ55667", "Ford", "Expedition", 2020, 17, 23);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (9, "FDH61671", "Chevrolet", "Tahoe", 2021, 16, 20);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (9, "XTT33440", "Chevrolet", "Suburban", 2021, 16, 20);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (9, "PQP02754", "Nissan", "Armada", 2020, 14, 19);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (9, "CTN20008", "GMC", "Yukon", 2020, 15, 22);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (9, "JZQ00025", "Toyota", "Sequoia", 2021, 13, 17);

-- Passenger Van
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (10, "FFQ12234", "Dodge", "Grand Caravan", 2020, 17, 25);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (10, "KRT99043", "Toyota", "Sienna", 2021, 35, 36);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (10, "GGU80209", "Ford", "Transit Wagon", 2019, 14, 18);

-- Trucks
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (11, "SKZ04580", "Nissan", "Titan", 2020, 16, 22);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (11, "CQV66700", "Ford", "F150", 2020, 19, 25);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (11, "KFL83301", "Jeep", "Gladiator", 2021, 16, 23);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (11, "BGT28809", "Ram", "1500", 2020, 20, 25);
INSERT INTO car (car_type_id, registration_number, make, model, year, city_mpg, highway_mpg)
VALUES (11, "NXZ55231", "Chevrolet", "Silverado", 2020, 16, 21);

-- -----------------------------------------------------
-- Upload rental_type info
-- -----------------------------------------------------

INSERT INTO rental_type (rental_type)
VALUES ("Daily");
INSERT INTO rental_type (rental_type)
VALUES ("Hourly");

-- -----------------------------------------------------
-- Upload damage_type info
-- -----------------------------------------------------

INSERT INTO damage_type (damage_type)
VALUES ("No Damage");
INSERT INTO damage_type (damage_type)
VALUES ("Minor Damage");
INSERT INTO damage_type (damage_type)
VALUES ("Significant Damage");

-- -----------------------------------------------------
-- Upload renter_info sample
-- -----------------------------------------------------
INSERT INTO `car_rental`.`renter_info` (`email`, `first_name`,
`last_name`, `street_address`, `city`, `state`, `zip_code`, `failed_attempts`, `password`, `licence_number`,
`membership_number`, `phone_number`) 
VALUES ('testuser@gmail.com', 'Uldren', 'Sov', '777 Main St.',
 'Bellevue', 'Washington', '12345', 0, 'Password1!', 'D090717',
 '001', '9876543210');

-- -----------------------------------------------------
-- Upload sample cc and rental information
-- -----------------------------------------------------
INSERT INTO car_rental.cc_info (`cc_name`, `cc_number`, `cc_exp_month`, `cc_exp_year`) VALUES ('Test Card', '1234567890123456', 01, 23);

INSERT INTO car_rental.rental_information (`renter_id`, `cc_info_id`, `car_id`, `rental_time`, `rental_location`, `rental_type`, `rental_return_date`, `rental_return_status`) VALUES 
(3, 1, 1, NOW(), 'Test Location', 1, 1, 0);