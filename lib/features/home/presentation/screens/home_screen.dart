import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/balance_card.dart';
import '../widgets/recent_transactions_list.dart';
import '../widgets/smart_insight_card.dart';
import '../widgets/greeting_header.dart';

/// Home Screen - Dashboard Principal
/// Exibe saldo, entradas, saídas, e transações recentes
class HomeScreen extends ConsumerStatefulWidget {
    const HomeScreen({super.key});

    @override
    ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> 
      with SingleTickerProviderStateMixin {
    late AnimationController _walletController;
    bool _isWalletRotating = false;

    @override
    void initState() {
          super.initState();
          _walletController = AnimationController(
                  duration: const Duration(milliseconds: 500),
                  vsync: this,
                );
    }

    @override
    void dispose() {
          _walletController.dispose();
          super.dispose();
    }

    void _onWalletTap() {
          if (!_isWalletRotating) {
                  setState(() => _isWalletRotating = true);
                  _walletController.forward().then((_) {
                            _walletController.reverse().then((_) {
                                        setState(() => _isWalletRotating = false);
                            });
                  });
          }
    }

    @override
    Widget build(BuildContext context) {
          return Scaffold(
                  backgroundColor: AppColors.background,
                  body: SafeArea(
                            child: CustomScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        slivers: [
                                                      // Header com saudação
                                                      SliverToBoxAdapter(
                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                                                                                        child: GreetingHeader(
                                                                                                            walletController: _walletController,
                                                                                                            onWalletTap: _onWalletTap,
                                                                                                          ),
                                                                                      ),
                                                                    ),

                                                      // Card principal de saldo
                                                      SliverToBoxAdapter(
                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                                                                        child: const BalanceCard(),
                                                                                      ),
                                                                    ),

                                                      // Insight inteligente
                                                      SliverToBoxAdapter(
                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                                                                                        child: const SmartInsightCard(),
                                                                                      ),
                                                                    ),

                                                      // Título transações recentes
                                                      SliverToBoxAdapter(
                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                                                                                        child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: [
                                                                                                                                  Text(
                                                                                                                                                          'Transações recentes',
                                                                                                                                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                                                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                                                                                  ),
                                                                                                                                                        ),
                                                                                                                                  TextButton(
                                                                                                                                                          onPressed: () {
                                                                                                                                                                                    // Navigate to history
                                                                                                                                                          },
                                                                                                                                                          child: Text(
                                                                                                                                                                                    'Ver todas',
                                                                                                                                                                                    style: TextStyle(
                                                                                                                                                                                                                color: AppColors.primary,
                                                                                                                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                                                                                                              ),
                                                                                                                                                                                  ),
                                                                                                                                                        ),
                                                                                                                                ],
                                                                                                          ),
                                                                                      ),
                                                                    ),

                                                      // Lista de transações recentes
                                                      const SliverToBoxAdapter(
                                                                      child: RecentTransactionsList(),
                                                                    ),

                                                      // Espaço inferior para o FAB
                                                      const SliverToBoxAdapter(
                                                                      child: SizedBox(height: 100),
                                                                    ),
                                                    ],
                                      ),
                          ),
                  floatingActionButton: FloatingActionButton(
                            onPressed: () => _showAddTransactionSheet(context),
                            backgroundColor: AppColors.primary,
                            elevation: 4,
                            child: const Icon(Icons.add, size: 28, color: Colors.white),
                          ),
                );
    }

    void _showAddTransactionSheet(BuildContext context) {
          showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddTransactionSheet(),
                );
    }
}

/// Sheet para adicionar nova transação
class AddTransactionSheet extends ConsumerStatefulWidget {
    const AddTransactionSheet({super.key});

    @override
    ConsumerState<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
    bool _isIncome = false;
    final _amountController = TextEditingController();
    final _noteController = TextEditingController();
    String? _selectedCategoryId;
    DateTime _selectedDate = DateTime.now();

    @override
    void dispose() {
          _amountController.dispose();
          _noteController.dispose();
          super.dispose();
    }

    @override
    Widget build(BuildContext context) {
          return Container(
                  decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                  padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                  child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                                      // Handle
                                                      Center(
                                                                      child: Container(
                                                                                        width: 40,
                                                                                        height: 4,
                                                                                        decoration: BoxDecoration(
                                                                                                            color: AppColors.divider,
                                                                                                            borderRadius: BorderRadius.circular(2),
                                                                                                          ),
                                                                                      ),
                                                                    ),
                                                      const SizedBox(height: 20),

                                                      // Título
                                                      Text(
                                                                      'Novo Lançamento',
                                                                      style: Theme.of(context).textTheme.headlineSmall,
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                      const SizedBox(height: 24),

                                                      // Toggle Entrada/Saída
                                                      _buildTypeToggle(),
                                                      const SizedBox(height: 24),

                                                      // Campo de valor
                                                      _buildAmountField(),
                                                      const SizedBox(height: 16),

                                                      // Seletor de categoria
                                                      _buildCategorySelector(),
                                                      const SizedBox(height: 16),

                                                      // Seletor de data
                                                      _buildDateSelector(),
                                                      const SizedBox(height: 16),

                                                      // Campo de observação
                                                      _buildNoteField(),
                                                      const SizedBox(height: 24),

                                                      // Botão salvar
                                                      ElevatedButton(
                                                                      onPressed: _saveTransaction,
                                                                      style: ElevatedButton.styleFrom(
                                                                                        backgroundColor: _isIncome ? AppColors.income : AppColors.expense,
                                                                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                                                                      ),
                                                                      child: const Text(
                                                                                        'Salvar',
                                                                                        style: TextStyle(
                                                                                                            fontSize: 16,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            color: Colors.white,
                                                                                                          ),
                                                                                      ),
                                                                    ),
                                                      const SizedBox(height: 16),
                                                    ],
                                      ),
                          ),
                );
    }

    Widget _buildTypeToggle() {
          return Container(
                  decoration: BoxDecoration(
                            color: AppColors.inputBackground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                            children: [
                                        Expanded(
                                                      child: GestureDetector(
                                                                      onTap: () => setState(() => _isIncome = true),
                                                                      child: AnimatedContainer(
                                                                                        duration: const Duration(milliseconds: 200),
                                                                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                                                                        decoration: BoxDecoration(
                                                                                                            color: _isIncome ? AppColors.incomeLight : Colors.transparent,
                                                                                                            borderRadius: BorderRadius.circular(12),
                                                                                                          ),
                                                                                        child: Text(
                                                                                                            'Entrada',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                                                  color: _isIncome ? AppColors.income : AppColors.textSecondary,
                                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                                ),
                                                                                                          ),
                                                                                      ),
                                                                    ),
                                                    ),
                                        Expanded(
                                                      child: GestureDetector(
                                                                      onTap: () => setState(() => _isIncome = false),
                                                                      child: AnimatedContainer(
                                                                                        duration: const Duration(milliseconds: 200),
                                                                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                                                                        decoration: BoxDecoration(
                                                                                                            color: !_isIncome ? AppColors.expenseLight : Colors.transparent,
                                                                                                            borderRadius: BorderRadius.circular(12),
                                                                                                          ),
                                                                                        child: Text(
                                                                                                            'Saída',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                                                  color: !_isIncome ? AppColors.expense : AppColors.textSecondary,
                                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                                ),
                                                                                                          ),
                                                                                      ),
                                                                    ),
                                                    ),
                                      ],
                          ),
                );
    }

    Widget _buildAmountField() {
          return TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                            hintText: 'R\$ 0,00',
                            hintStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textTertiary,
                                      ),
                            border: InputBorder.none,
                            prefixText: 'R\$ ',
                            prefixStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: _isIncome ? AppColors.income : AppColors.expense,
                                      ),
                          ),
                );
    }

    Widget _buildCategorySelector() {
          return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                            color: AppColors.inputBackground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                  child: Row(
                            children: [
                                        const Icon(Icons.category_outlined, color: AppColors.textSecondary),
                                        const SizedBox(width: 12),
                                        Text(
                                                      _selectedCategoryId ?? 'Selecionar categoria',
                                                      style: TextStyle(
                                                                      color: _selectedCategoryId != null 
                                                                          ? AppColors.textPrimary 
                                                                          : AppColors.textTertiary,
                                                                    ),
                                                    ),
                                        const Spacer(),
                                        const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                                      ],
                          ),
                );
    }

    Widget _buildDateSelector() {
          return GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                        color: AppColors.inputBackground,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                            child: Row(
                                        children: [
                                                      const Icon(Icons.calendar_today_outlined, color: AppColors.textSecondary),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                                      _formatDate(_selectedDate),
                                                                      style: const TextStyle(color: AppColors.textPrimary),
                                                                    ),
                                                      const Spacer(),
                                                      const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                                                    ],
                                      ),
                          ),
                );
    }

    Widget _buildNoteField() {
          return TextField(
                  controller: _noteController,
                  maxLines: 2,
                  decoration: InputDecoration(
                            hintText: 'Observação (opcional)',
                            prefixIcon: const Icon(Icons.notes_outlined, color: AppColors.textSecondary),
                          ),
                );
    }

    String _formatDate(DateTime date) {
          final now = DateTime.now();
          if (date.year == now.year && date.month == now.month && date.day == now.day) {
                  return 'Hoje';
          }
          return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }

    Future<void> _selectDate() async {
          final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
          if (picked != null) {
                  setState(() => _selectedDate = picked);
          }
    }

    void _saveTransaction() {
          // TODO: Implement save logic
          Navigator.of(context).pop();
    }
}
