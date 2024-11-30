import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key,required this.currentFilter});
    final Map<Filter,bool> currentFilter;
  @override
  State<FiltersScreen> createState() {
    // TODO: implement createState
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FiltersScreen> {
  var _glutenFreeSet = false; 
   var _lactoseFreeSet = false;
  var _vegetrianSet = false;
  var _veganSet = false;
@override
  void initState() {   
  super.initState();
  _glutenFreeSet = widget.currentFilter[Filter.glutenFree]!; 
    _lactoseFreeSet = widget.currentFilter[Filter.lactoseFree]!; 
 _vegetrianSet = widget.currentFilter[Filter.vegetarian]!; 
   _veganSet = widget.currentFilter[Filter.vegan]!; 
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your filters!"),
        ),
        body: PopScope(
          
  canPop: false,
  onPopInvokedWithResult: (bool didPop, dynamic result) {
    if(didPop) return;
      Navigator.of(context).pop({
        Filter.glutenFree: _glutenFreeSet,
        Filter.lactoseFree: _lactoseFreeSet,
        Filter.vegetarian: _vegetrianSet,
        Filter.vegan: _veganSet,
      });
    },
          child: Column(
            children: [
              SwitchListTile(
                value: _glutenFreeSet,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenFreeSet = isChecked;
                  });
                },
                title: Text(
                  "Gluten-free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: Text(
                  "Only include Gluten-free meals!",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),SwitchListTile(
                value: _lactoseFreeSet,
                onChanged: (isChecked) {
                  setState(() {
                    _lactoseFreeSet = isChecked;
                  });
                },
                title: Text(
                  "Lactose-free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: Text(
                  "Only include lactose-free meals!",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _vegetrianSet,
                onChanged: (isChecked) {
                  setState(() {
                    _vegetrianSet = isChecked;
                  });
                },
                title: Text(
                  "Vegetrian",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: Text(
                  "Only include vegetrian meals!",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _veganSet,
                onChanged: (isChecked) {
                  setState(() {
                    _veganSet = isChecked;
                  });
                },
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: Text(
                  "Only include Vegan meals!",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
            ],
          ),
        ));
  }
}
