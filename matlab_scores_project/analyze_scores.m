%% Student Scores Statistical Analysis
% This script reads student scores from a CSV file and performs
% statistical analysis including mean, median, mode, variance,
% standard deviation, score separation, and visualization.

clear; clc; close all;

%% Read Data from CSV File
fprintf('=== Student Scores Statistical Analysis ===\n\n');

% Read the CSV file
data = readtable('student_scores.csv');
scores = data.Score;
studentIDs = data.StudentID;

fprintf('Successfully loaded %d student scores.\n\n', length(scores));

%% Calculate Statistical Measures
meanScore = mean(scores);
medianScore = median(scores);
modeScore = mode(scores);
varianceScore = var(scores);
stdScore = std(scores);

% Display statistics
fprintf('--- Statistical Measures ---\n');
fprintf('Mean:               %.2f\n', meanScore);
fprintf('Median:             %.2f\n', medianScore);
fprintf('Mode:               %.2f\n', modeScore);
fprintf('Variance:           %.2f\n', varianceScore);
fprintf('Standard Deviation: %.2f\n\n', stdScore);

%% Separate Scores (>15 and <10)
% Find students with scores more than 15
highScoresIdx = scores > 15;
highScores = scores(highScoresIdx);
highScoreStudents = studentIDs(highScoresIdx);

% Find students with scores less than 10
lowScoresIdx = scores < 10;
lowScores = scores(lowScoresIdx);
lowScoreStudents = studentIDs(lowScoresIdx);

% Display high scores (>15)
fprintf('--- Students with Scores > 15 ---\n');
fprintf('Count: %d students\n', length(highScores));
if ~isempty(highScores)
    for i = 1:length(highScores)
        fprintf('Student %d: Score = %d\n', highScoreStudents(i), highScores(i));
    end
end
fprintf('\n');

% Display low scores (<10)
fprintf('--- Students with Scores < 10 ---\n');
fprintf('Count: %d students\n', length(lowScores));
if ~isempty(lowScores)
    for i = 1:length(lowScores)
        fprintf('Student %d: Score = %d\n', lowScoreStudents(i), lowScores(i));
    end
end
fprintf('\n');

%% Generate Plots
% Create a figure with two subplots
figure('Name', 'Student Scores Analysis', 'Position', [100, 100, 1200, 500]);

% Subplot 1: Histogram
subplot(1, 2, 1);
histogram(scores, 'BinWidth', 2, 'FaceColor', [0.2 0.6 0.8], 'EdgeColor', 'black');
xlabel('Score');
ylabel('Frequency');
title('Histogram of Student Scores');
grid on;

% Add mean line to histogram
hold on;
xline(meanScore, 'r--', 'LineWidth', 2, 'Label', sprintf('Mean = %.2f', meanScore));
hold off;

% Subplot 2: Linear Plot
subplot(1, 2, 2);
plot(studentIDs, scores, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 6, ...
    'MarkerFaceColor', [0.2 0.6 0.8]);
xlabel('Student ID');
ylabel('Score');
title('Linear Plot of Student Scores');
grid on;

% Add reference lines for thresholds
hold on;
yline(15, 'g--', 'LineWidth', 1.5, 'Label', 'High (>15)');
yline(10, 'r--', 'LineWidth', 1.5, 'Label', 'Low (<10)');
yline(meanScore, 'm:', 'LineWidth', 1.5, 'Label', sprintf('Mean = %.2f', meanScore));
hold off;

% Save the figure
saveas(gcf, 'scores_analysis_plots.png');
saveas(gcf, 'scores_analysis_plots.fig');
fprintf('Plots saved as scores_analysis_plots.png and scores_analysis_plots.fig\n\n');

%% Save Results to Output File
outputFile = 'analysis_results.txt';
fid = fopen(outputFile, 'w');

fprintf(fid, '=====================================================\n');
fprintf(fid, '       STUDENT SCORES STATISTICAL ANALYSIS\n');
fprintf(fid, '=====================================================\n\n');

fprintf(fid, 'Analysis Date: %s\n', datestr(now));
fprintf(fid, 'Number of Students: %d\n\n', length(scores));

fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, '                STATISTICAL MEASURES\n');
fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, 'Mean:               %.2f\n', meanScore);
fprintf(fid, 'Median:             %.2f\n', medianScore);
fprintf(fid, 'Mode:               %.2f\n', modeScore);
fprintf(fid, 'Variance:           %.2f\n', varianceScore);
fprintf(fid, 'Standard Deviation: %.2f\n\n', stdScore);

fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, '           STUDENTS WITH SCORES > 15\n');
fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, 'Count: %d students\n', length(highScores));
if ~isempty(highScores)
    for i = 1:length(highScores)
        fprintf(fid, 'Student %d: Score = %d\n', highScoreStudents(i), highScores(i));
    end
end
fprintf(fid, '\n');

fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, '           STUDENTS WITH SCORES < 10\n');
fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, 'Count: %d students\n', length(lowScores));
if ~isempty(lowScores)
    for i = 1:length(lowScores)
        fprintf(fid, 'Student %d: Score = %d\n', lowScoreStudents(i), lowScores(i));
    end
end
fprintf(fid, '\n');

fprintf(fid, '-----------------------------------------------------\n');
fprintf(fid, '                 ALL STUDENT SCORES\n');
fprintf(fid, '-----------------------------------------------------\n');
for i = 1:length(scores)
    fprintf(fid, 'Student %2d: Score = %2d\n', studentIDs(i), scores(i));
end

fprintf(fid, '\n=====================================================\n');
fprintf(fid, '                    END OF REPORT\n');
fprintf(fid, '=====================================================\n');

fclose(fid);

fprintf('Results saved to %s\n', outputFile);
fprintf('\n=== Analysis Complete ===\n');
