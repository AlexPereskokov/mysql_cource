-- ������������ ������� �2.

/* ������� �1.
	������� ���� .my.cnf */
[mysql]
user=root
password=
-- �������� �� �������� ����� ���� ����� �������� ������ ��������� ����� ���������� ����� � ������� (mysql -u root -p)

/*������� �2.
	�������� ���� ������ example c �������� users � ����� ���������: id & name */
-- ������� mysql
mysql -u root -p
-- ������ ���� ������ example
CREATE DATABASE  example;
-- C������� ������� users c ����� �������� ������ ����� ������ 
CREATE TABLE  users (id SERIAL PRIMARY KEY,name VARCHAR(255) COMMENT '��� ������������');
-- ��������� ����� ������ �����, ������������� ������� �� ���������� �����
exit

/*������� �3.
	������� ���� ��������� example ��, ���������� ���������� ����� � �� sample */
-- �������� �� sample
CREATE DATABASE sample;
-- ������� ����
mysqldump -u root -p example > sample.sql
mysql -u root -p sample < sample.SQL
-- ����� ��� �������� ��������� ����
mysql -u root -p
SHOW databeses;
-- ������� �������
DESCRIBE sample.users;

/*������� �4.
	���� ������� help_keyword, �� ������ ������ 100 ����� */
-- ������ ����
mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > firs_100_rows_h_k.sql
-- ������������ ���� � ��������� �� (dump_h_k)
mysql -u root -p dump_h_k < firs_100_rows_h_k.SQL
-- �������� ������, ������� ��������������� ����� mysql.