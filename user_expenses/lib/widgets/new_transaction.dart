import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key? key}) : super(key: key);
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler) {
    print("Constructor newTransaction widget ");
  }

  @override
  _NewTransactionState createState() {
    print("createState newTransaction Widget ");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState() {
    print("Constructor newTransaction State ");
  }

  // --initState
  @override
  void initState() {
    // TODO: implement initState
    // -- Load some data form internet/database
    print("initState");
    super.initState();
  }

  //-- didupdateWidget widget
  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    print("didupdateWidget()");
    super.didUpdateWidget(oldWidget);
  }

  // -- dispose
  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransactionHandler(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context)
        .pop(); // closes the bottom modal sheet after entering the data.
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                controller: _amountController,
                // onChanged: (value) => amountInput = value,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date Chosen'
                          : 'Picked Date: ${DateFormat.yMMMEd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple)),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  "Add Transaction",
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
