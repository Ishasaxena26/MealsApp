import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; //with this import we can connect the filter screen widget to the provider and get access to the provider

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/provider/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    // required this.currentFilters
  });
  // final Map<Filter, bool> currentFilters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(
        filtersProvider); //sets up a listener that re executes the build method whenver the state of the provider changes ...ex- chnging the filter

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      // body: WillPopScope(
      //   //onWillPop returns a future
      //   // onWillPop: () async {
      //   //   //pop allows us to pass some data along with it.Some data, which will then be available in the placewhere we navigated to this screen,
      //   //   Navigator.of(context).pop({
      //   //     //the below Map will be returned by the filter screen when it is popped..when back button is pressed
      //   //     Filter.glutenFree: _glutenFreeFilterSet,
      //   //     Filter.lactoseFree: _lactoseFreeFilterSet,
      //   //     Filter.vegan: _veganFilterSet,
      //   //     Filter.vegetarian: _vegetarianFilterSet,
      //   //   });
      //   //   return false; //as we dont want to pop twice

      //   //onWillPop returns a future
      //   onWillPop: () async {
      //     //storing filters as we leave the page
      //     ref.read(filtersProvider.notifier).setFiltersss({
      //       Filter.glutenFree: _glutenFreeFilterSet,
      //       Filter.lactoseFree: _lactoseFreeFilterSet,
      //       Filter.vegan: _veganFilterSet,
      //       Filter.vegetarian: _vegetarianFilterSet,
      //     });
      //     //flutter will perform the pop operation
      //     return true;
      //   },

      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              //func shld be boolean and it is called by flutter and flutter passes a boolean value
              ref.read(filtersProvider.notifier).setFilter(
                  Filter.glutenFree, isChecked); //func to set only one filter
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text('Only include gluten-free meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text('Only include lactose-free meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text('Only include vegan meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text('Only include vegetarian meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
