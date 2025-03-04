// lib/widgets/project_card.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/project.dart';
import '../screens/project_detail_screen.dart';
import '../screens/responsive_layout_wrapper.dart';

// 프로젝트 카드 위젯 - 각 프로젝트 정보를 보여줍니다
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);
  Future<void> _launchUrl(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw '해당 URL을 열 수 없습니다: $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponsiveLayoutWrapper(
              child: ProjectDetailScreen(
                project: project,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로젝트 이미지
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                project.imageUrl,
                height: 350,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 프로젝트 제목
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  // 프로젝트 설명
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 12),
                  // 사용된 기술 목록
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.map((tech) {
                      return Chip(
                        label: Text(tech),
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // 버튼 영역
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // GitHub 버튼

                      // GitHub 링크 버튼 (여러 개일 경우)
                      if (project.allGithubUrls.isNotEmpty)
                        _buildGithubButtons(context),

                      // 라이브 데모 버튼 (있는 경우에만 표시)
                      if (project.liveUrl != null &&
                          project.liveUrl!.isNotEmpty)
                        TextButton.icon(
                          icon: Icon(Icons.visibility),
                          label: Text('라이브 데모'),
                          onPressed: () async {
                            _launchUrl(project.liveUrl!);
                          },
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

  // GitHub 링크 버튼 영역 (여러 개일 경우 모두 표시)
  Widget _buildGithubButtons(BuildContext context) {
    final githubUrls = project.allGithubUrls;

    // GitHub 링크가 하나만 있는 경우
    if (githubUrls.length == 1) {
      return TextButton.icon(
        icon: Icon(Icons.code),
        label: Text('GitHub'),
        onPressed: () => _launchUrl(githubUrls[0]['url']!),
      );
    }

    // GitHub 링크가 여러 개인 경우
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'GitHub 저장소',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(width: 12),
        // 링크 버튼들을 중앙 정렬하여 표시
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: githubUrls
              .map((urlInfo) => TextButton.icon(
                    icon: const Icon(Icons.code),
                    label: Text(urlInfo['label'] ?? 'GitHub'),
                    onPressed: () => _launchUrl(urlInfo['url']!),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
