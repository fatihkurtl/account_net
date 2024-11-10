import 'package:account_net/core/components/custom_appbar.dart';
import 'package:account_net/core/components/custom_date.dart';
import 'package:account_net/core/components/custom_dropdown.dart';
import 'package:account_net/core/components/custom_floating_button.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedDepartment = 'Tümü';
  bool _showOnlyUnpaid = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  final List<String> _departments = [
    'Tümü',
    'Yönetim',
    'Geliştirme',
    'Tasarım',
    'Satış'
  ];

  // Örnek personel verileri
  List<Employee> employees = [
    Employee(
      name: 'John Doe',
      position: 'Yönetici',
      department: 'Yönetim',
      salary: 25000,
      phoneNumber: '0555 111 2233',
      email: 'john@company.com',
      startDate: DateTime(2022, 5, 15),
      photoUrl: 'lib/assets/images/user_man.png',
    ),
    Employee(
      name: 'Jane Smith',
      position: 'Kıdemli Geliştirici',
      department: 'Geliştirme',
      salary: 20000,
      phoneNumber: '0555 222 3344',
      email: 'jane@company.com',
      startDate: DateTime(2023, 1, 10),
      photoUrl: 'lib/assets/images/user_woman.png',
    ),
    // Diğer örnek veriler...
  ];

  List<Employee> get _filteredEmployees {
    return employees.where((employee) {
      final matchesSearch = employee.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          employee.position.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesDepartment = _selectedDepartment == 'Tümü' ||
          employee.department == _selectedDepartment;
      final matchesPaymentFilter = !_showOnlyUnpaid || !employee.isSalaryPaid;

      return matchesSearch && matchesDepartment && matchesPaymentFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: CustomAppBar(
        title: 'Personel Listesi',
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          letterSpacing: 0.5,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey[800],
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildEmployeeStats(),
          Expanded(
            child: _filteredEmployees.isEmpty
                ? _buildEmptyState()
                : _buildEmployeeList(),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _addEmployee(),
        icon: Icons.person_add,
        buttonText: 'Personel Ekle',
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CustomTextField(
            controller: _searchController,
            hintText: 'Personel Ara...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            onChanged: (value) => setState(() => _searchQuery = value),
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._departments.map((dept) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        backgroundColor: Colors.grey[200],
                        selectedColor: Colors.grey.withOpacity(0.6),
                        label: Text(dept),
                        selected: _selectedDepartment == dept,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedDepartment = dept);
                          }
                        },
                      ),
                    )),
                FilterChip(
                  label: const Text('Maaşı Ödenmeyenler'),
                  selected: _showOnlyUnpaid,
                  onSelected: (selected) {
                    setState(() => _showOnlyUnpaid = selected);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeStats() {
    final totalEmployees = _filteredEmployees.length;
    final unpaidCount = _filteredEmployees.where((e) => !e.isSalaryPaid).length;
    final totalSalaries =
        _filteredEmployees.fold<double>(0, (sum, emp) => sum + emp.salary);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildStatCard(
            'Toplam Personel',
            totalEmployees.toString(),
            Icons.people,
            Colors.blue,
          ),
          _buildStatCard(
            'Maaş Bekleyen',
            unpaidCount.toString(),
            Icons.payment,
            Colors.orange,
          ),
          _buildStatCard(
            'Toplam Maaş',
            '₺${NumberFormat.compact().format(totalSalaries)}',
            Icons.monetization_on,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeList() {
    return ListView.builder(
      itemCount: _filteredEmployees.length,
      itemBuilder: (context, index) {
        return EmployeeListItem(
          employee: _filteredEmployees[index],
          onSalaryPaid: () => _toggleSalaryPaid(index),
          onTap: () => _showEmployeeDetails(_filteredEmployees[index]),
          onEdit: () {},
          onDelete: () {},
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Personel Bulunamadı',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Arama kriterlerinizle eşleşen personel bulunmamaktadır.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showEmployeeDetails(Employee employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: EmployeeDetailsPanel(employee: employee),
        ),
      ),
    );
  }

  void _addEmployee() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        String name = '';
        String position = '';
        String department = _departments.first;
        double salary = 0;
        String phone = '';
        String email = '';

        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Yeni Personel Ekle'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Ad Soyad',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _positionController,
                    hintText: 'Pozisyon',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    hintText: 'Departman',
                    items: _departments,
                    selectedItem: department,
                    onChanged: (String? value) {
                      _departmentController.text = value ?? _departments.first;
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _salaryController,
                    hintText: 'Maaş',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alan zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneNumberController,
                    hintText: 'Telefon',
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'E-posta',
                    keyboardType: TextInputType.emailAddress,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  const SizedBox(height: 16),
                  CustomDateField(
                    hintText: 'İşe Giriş Tarihi',
                    onChanged: (value) {
                      setState(() {
                        _startDateController.text = value.toString();
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'İptal',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Ekle',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  setState(() {
                    employees.add(Employee(
                      name: name,
                      position: position,
                      department: department,
                      salary: salary,
                      phoneNumber: phone,
                      email: email,
                      startDate: DateTime.now(),
                    ));
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Personel başarıyla eklendi'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleSalaryPaid(int index) {
    setState(() {
      final employee = employees[index];
      employee.isSalaryPaid = !employee.isSalaryPaid;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            employee.isSalaryPaid
                ? '${employee.name} için maaş ödemesi yapıldı olarak işaretlendi'
                : '${employee.name} için maaş ödemesi yapılmadı olarak işaretlendi',
          ),
          action: SnackBarAction(
            label: 'Geri Al',
            onPressed: () {
              setState(() {
                employee.isSalaryPaid = !employee.isSalaryPaid;
              });
            },
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sıralama Seçenekleri',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sort_by_alpha),
                      title: const Text('İsme Göre'),
                      onTap: () {
                        setState(() {
                          employees.sort((a, b) => a.name.compareTo(b.name));
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: const Text('Maaşa Göre'),
                      onTap: () {
                        setState(() {
                          employees
                              .sort((a, b) => b.salary.compareTo(a.salary));
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.date_range),
                      title: const Text('Başlangıç Tarihine Göre'),
                      onTap: () {
                        setState(() {
                          employees.sort(
                              (a, b) => b.startDate.compareTo(a.startDate));
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Employee {
  final String name;
  final String position;
  final String department;
  final double salary;
  final String phoneNumber;
  final String email;
  final DateTime startDate;
  final String? photoUrl;
  bool isSalaryPaid;

  Employee({
    required this.name,
    required this.position,
    required this.department,
    required this.salary,
    required this.phoneNumber,
    required this.email,
    required this.startDate,
    this.photoUrl,
    this.isSalaryPaid = false,
  });
}

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final VoidCallback onSalaryPaid;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EmployeeListItem({
    required this.employee,
    required this.onSalaryPaid,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(employee.name),
      background: Container(
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          onDelete();
          return true;
        }
        return false;
      },
      child: Card(
        elevation: 4,
        color: Colors.grey[200],
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: employee.photoUrl != null
                ? AssetImage(employee.photoUrl!)
                : const AssetImage('assets/default_avatar.png')
                    as ImageProvider,
          ),
          title: Text(
            employee.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${employee.position} • ${employee.department}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  employee.isSalaryPaid
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: employee.isSalaryPaid ? Colors.green : Colors.grey,
                ),
                onPressed: onSalaryPaid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeDetailsPanel extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsPanel({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            employee.position,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Departman: ${employee.department}',
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(height: 4),
          Text(
            'Maaş: ₺${employee.salary.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.phone, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                employee.phoneNumber,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.email, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                employee.email,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'İşe Başlama Tarihi: ${DateFormat('dd/MM/yyyy').format(employee.startDate)}',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
