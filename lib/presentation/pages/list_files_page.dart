import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/file_cubit.dart';

class ListFilesPage extends StatelessWidget {
  const ListFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FileCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Arquivos Enviados')),
      body: FutureBuilder(
        future: cubit.listFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
          if (snapshot.hasError) return const Text('Erro ao carregar arquivos');
          final files = snapshot.data!;
          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (_, index) => ListTile(
              title: Text(files[index].name),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  // Abre link de download
                  final url = files[index].url;
                  // Para produção, abrir com launchUrl
                  print('Download: $url');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}