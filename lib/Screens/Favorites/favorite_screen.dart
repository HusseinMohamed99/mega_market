import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/model/favorite/favorite_model.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: MainCubit.get(context).favoritesModel!.data!.data!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.imagesNodata),
                      Text(
                        'Your Favorites is empty',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Be sure to fill your favorite with something you like',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                : ConditionalBuilder(
                    condition: state is! FavoritesLoadingStates,
                    builder: (context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ProductList(
                        favoritesModel: MainCubit.get(context)
                            .favoritesModel!
                            .data!
                            .data![index],
                        // favoritesModel:
                        //   MainCubit.get(context)
                        //       .favoritesModel!
                        //       .data!
                        //       .data![index]
                        //       .product,
                      ),
                      separatorBuilder: (context, index) => const MyDivider(),
                      itemCount: MainCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data!
                          .length,
                    ),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ));
      },
    );
  }

// Widget buildListProduct(
//   model,
//   context, {
//   isOldPrice = true,
// }) =>
//     Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: SizedBox(
//         height: 400.0,
//         child: Column(
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.bottomEnd,
//               children: [
//                 Image(
//                   image: NetworkImage(
//                     model.image,
//                   ),
//                   height: 250.0,
//                   width: double.infinity,
//                 ),
//                 if (model.discount != 0 && isOldPrice)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 5.0,
//                     ),
//                     color: Colors.red,
//                     child: const Text(
//                       'OFFERS',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10.0,
//                       ),
//                     ),
//                   ),
//                 Positioned(
//                   bottom: 10,
//                   left: 10,
//                   child: CircleAvatar(
//                     backgroundColor: MainCubit.get(context).cart[model.id]
//                         ? Colors.deepOrangeAccent
//                         : Colors.grey[300],
//                     child: IconButton(
//                       onPressed: () {
//                         MainCubit.get(context).changeCart(model.id);
//                       },
//                       icon: const Icon(
//                         Icons.add_shopping_cart,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20.0),
//                     child: Text(
//                       model.name,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(height: 1.5),
//                     ),
//                   ),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       Text(
//                         '${model.price.round()}',
//                         style: const TextStyle(
//                           color: Colors.deepOrange,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10.0,
//                       ),
//                       if (model.discount != 0 && isOldPrice)
//                         Text(
//                           '${model.oldPrice.round()}',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       const Spacer(),
//                       CircleAvatar(
//                         backgroundColor:
//                             MainCubit.get(context).favorites[model.id]
//                                 ? Colors.red
//                                 : Colors.grey[300],
//                         child: IconButton(
//                           onPressed: () {
//                             MainCubit.get(context).changeFavorites(model.id);
//                           },
//                           icon: const Icon(
//                             IconBroken.Delete,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.favoritesModel});

  final bool isOldPrice = true;
  final FavoritesData favoritesModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 400.0,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage(
                    favoritesModel.product!.image!,
                  ),
                  height: 250.0,
                  width: double.infinity,
                ),
                if (favoritesModel.product!.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    color: Colors.red,
                    child: const Text(
                      'OFFERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor:
                        MainCubit.get(context).cart[favoritesModel.product!.id]
                            ? Colors.deepOrangeAccent
                            : Colors.grey[300],
                    child: IconButton(
                      onPressed: () {
                        MainCubit.get(context)
                            .changeCart(favoritesModel.product!.id!);
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      favoritesModel.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.5),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${favoritesModel.product!.price.round()}',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (favoritesModel.product!.discount != 0 && isOldPrice)
                        Text(
                          '${favoritesModel.product!.oldPrice.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: MainCubit.get(context)
                                .favorites[favoritesModel.product!.id]
                            ? Colors.red
                            : Colors.grey[300],
                        child: IconButton(
                          onPressed: () {
                            MainCubit.get(context)
                                .changeFavorites(favoritesModel.product!.id!);
                          },
                          icon: const Icon(
                            IconBroken.Delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}