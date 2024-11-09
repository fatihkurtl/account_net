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
      photoUrl: 'https://example.com/photo1.jpg',
    ),
    Employee(
      name: 'Jane Smith',
      position: 'Kıdemli Geliştirici',
      department: 'Geliştirme',
      salary: 20000,
      phoneNumber: '0555 222 3344',
      email: 'jane@company.com',
      startDate: DateTime(2023, 1, 10),
      photoUrl: 'https://example.com/photo2.jpg',
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
      appBar: _buildAppBar(),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addEmployee(),
        icon: const Icon(Icons.person_add),
        label: const Text('Personel Ekle'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Personel Listesi'),
      actions: [
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: _showSortOptions,
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: _showMoreOptions,
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._departments.map((dept) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(dept),
                        selected: _selectedDepartment == dept,
                        onSelected: (selected) {
                          if (selected)
                            setState(() => _selectedDepartment = dept);
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
          title: const Text('Yeni Personel Ekle'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Ad Soyad'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
                    onSaved: (value) => name = value ?? '',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Pozisyon'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Bu alan zorunludur' : null,
                    onSaved: (value) => position = value ?? '',
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Departman'),
                    items: _departments.map((String department) {
                      return DropdownMenuItem(
                        value: department,
                        child: Text(department),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      department = value ?? _departments.first;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Maaş',
                      prefixText: '₺',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Bu alan zorunludur';
                      if (double.tryParse(value) == null)
                        return 'Geçerli bir sayı giriniz';
                      return null;
                    },
                    onSaved: (value) =>
                        salary = double.tryParse(value ?? '0') ?? 0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Telefon'),
                    keyboardType: TextInputType.phone,
                    onSaved: (value) => phone = value ?? '',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-posta'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => email = value ?? '',
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Kaydet'),
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
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          const ListTile(
            title: Text('Sıralama'),
            enabled: false,
          ),
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
                employees.sort((a, b) => b.salary.compareTo(a.salary));
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text('Başlangıç Tarihine Göre'),
            onTap: () {
              setState(() {
                employees.sort((a, b) => b.startDate.compareTo(a.startDate));
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text('İsme Göre Sırala'),
            onTap: () {
              setState(() {
                employees.sort((a, b) => a.name.compareTo(b.name));
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Maaşa Göre Sırala'),
            onTap: () {
              setState(() {
                employees.sort((a, b) => b.salary.compareTo(a.salary));
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text('Başlangıç Tarihine Göre Sırala'),
            onTap: () {
              setState(() {
                employees.sort((a, b) => a.startDate.compareTo(b.startDate));
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Uygulama Hakkında'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Personel Yönetimi',
                applicationVersion: '1.0.0',
                children: [
                  const Text(
                      'Bu uygulama, şirket personel yönetimini kolaylaştırmak için geliştirilmiştir.'),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ayarlar'),
            onTap: () {
              Navigator.pop(context);
              // Ayarlar ekranına yönlendirme yapılabilir.
            },
          ),
        ],
      ),
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

  const EmployeeListItem({
    required this.employee,
    required this.onSalaryPaid,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: employee.photoUrl != null
            ? NetworkImage(employee.photoUrl!)
            : const AssetImage('assets/default_avatar.png') as ImageProvider,
      ),
      title: Text(employee.name),
      subtitle: Text('${employee.position} • ${employee.department}'),
      trailing: IconButton(
        icon: Icon(
          employee.isSalaryPaid
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: employee.isSalaryPaid ? Colors.green : Colors.grey,
        ),
        onPressed: onSalaryPaid,
      ),
      onTap: onTap,
    );
  }
}

class EmployeeDetailsPanel extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsPanel({required this.employee, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(employee.position),
          Text('Departman: ${employee.department}'),
          Text('Maaş: ₺${employee.salary.toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.phone, size: 20),
              const SizedBox(width: 8),
              Text(employee.phoneNumber),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.email, size: 20),
              const SizedBox(width: 8),
              Text(employee.email),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'İşe Başlama Tarihi: ${DateFormat('dd/MM/yyyy').format(employee.startDate)}',
          ),
        ],
      ),
    );
  }
}
