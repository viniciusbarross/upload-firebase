// lib/presentation/pages/upload_page.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_app/presentation/cubits/file_cubit.dart';
import 'package:upload_app/presentation/states/file_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../routes/app_routes.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? selectedPath;

  @override
  void initState() {
    super.initState();
    context.read<FileCubit>().listFiles();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FileCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Arquivos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          )
        ],
      ),
      body: BlocBuilder<FileCubit, FileState>(
        builder: (context, state) {
          if (state is FileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final files = state is FileLoaded ? state.files : [];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (selectedPath != null && File(selectedPath!).existsSync())
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text("Pré-visualização do arquivo:",
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          if (selectedPath!.endsWith(".png") ||
                              selectedPath!.endsWith(".jpg") ||
                              selectedPath!.endsWith(".jpeg"))
                            Image.file(File(selectedPath!), height: 200)
                          else
                            Text(
                              selectedPath!.split("/").last,
                              style: const TextStyle(fontSize: 14),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    await cubit.uploadFile(selectedPath!);
                                    await cubit.listFiles();
                                    setState(() => selectedPath = null);
                                  },
                                  icon: const Icon(
                                    Icons.upload,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    "Enviar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      setState(() => selectedPath = null),
                                  child: const Text("Cancelar"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      setState(() => selectedPath = result.files.single.path);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Selecionar Arquivo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 8),
                const Text("Arquivos Enviados:",
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Expanded(
                  child: files.isEmpty
                      ? const Center(child: Text("Nenhum arquivo enviado"))
                      : ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return ListTile(
                              title: Text(file.name),
                              leading: const Icon(Icons.insert_drive_file),
                              trailing: Wrap(
                                spacing: 8,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: () async {
                                      final url = file.url;
                                      final isImage =
                                          file.name.endsWith(".png") ||
                                              file.name.endsWith(".jpg") ||
                                              file.name.endsWith(".jpeg");

                                      if (isImage) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                            child: Image.network(url),
                                          ),
                                        );
                                      } else {
                                        if (await canLaunchUrl(
                                            Uri.parse(url))) {
                                          await launchUrl(Uri.parse(url),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Não foi possível abrir o arquivo")),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      final confirmed = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                            "Confirmar Exclusão",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          content: const Text(
                                            "Tem certeza que deseja deletar este arquivo?",
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text(
                                                "Cancelar",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text(
                                                "Deletar",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (confirmed == true) {
                                        await context
                                            .read<FileCubit>()
                                            .deleteFile(file.name);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              onTap: () async {
                                final url = file.url;
                                final isImage = file.name.endsWith(".png") ||
                                    file.name.endsWith(".jpg") ||
                                    file.name.endsWith(".jpeg");

                                if (isImage) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Image.network(url),
                                    ),
                                  );
                                } else {
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url),
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Não foi possível abrir o arquivo")),
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
